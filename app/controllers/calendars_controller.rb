class CalendarsController < ApplicationController
  require 'json'

  def show
    @calendar = Calendar.find(params[:id])
    account_company = Company.find(session[:the_company].first)
    @partner_days_hours = []
    @calendar.companies.each do |company|
      if company.id != session[:the_company].first.to_i
        Time.zone = company.time_zone_offset
        open_t = Time.zone.parse("#{company.open_time}").in_time_zone("#{account_company.time_zone_offset}")
        open_time = "#{open_t.to_formatted_s(:time)}"
        close_t = Time.zone.parse("#{company.close_time}").in_time_zone("#{account_company.time_zone_offset}")
        close_time = "#{close_t.to_formatted_s(:time)}"
        @partner_days_hours << "#{company.name}: #{JSON.parse(company.work_days).join(', ')} | #{open_time} to #{close_time}"
      end
    end
    session[:the_calendar] = @calendar.id
    today = Time.zone.today
    if today.month == 10 || 11 || 12
      if @calendar.holidays.last.start_time.year <= today.year
        add_holidays(today.year + 1)
      end
    end
    @meetings = Meeting.where(calendar_id: @calendar.id)
  end

  def add_partner
    session[:partners].push(params[:id]) unless session[:partners].include?(params[:id])
  end

  def new
    @calendar = Calendar.new
    @companies = Company.all
    @company = Company.find(session[:the_company])
  end

  def create
    @company = Company.find(session[:the_company])
    partners = session[:partners]
    created = false
    @company.first.calendars.each do |c|
      if c.companies.pluck(:id) == partners.map{|i| i.to_i}
        created = true
        @calendar = c
      end
    end
    if created
      flash[:notice] = "!!This Calendar Already Exists!!"
      redirect_to calendar_path(@calendar)
    else
      @calendar = Calendar.create
      session[:the_calendar] = @calendar.id
      partners.each do |partner|
        @partnership = Partnership.create(company_id: partner, calendar_id: @calendar.id)
      end
      names = @calendar.companies.pluck(:name).sort.join(' | ')
      @calendar.update(name: "Calendar for #{names}")
      add_holidays(Time.zone.today.year)
      redirect_to calendar_path(@calendar)
    end
  end

  def add_holidays(year)
    calendar = Calendar.find(session[:the_calendar])
    companies = calendar.companies
    companies.each do |company|
      hash = api_call(company.country_code, year)
      hash["response"]["holidays"].each do |holiday|
        if holiday["type"].first == "National holiday"
          meeting = Meeting.find_or_create_by(
            name: holiday["name"],
            type: "Holiday",
            start_time: "#{holiday["date"]["iso"]} 00:00:00",
            end_time: "#{holiday["date"]["iso"]} 23:59:00",
            country_code: company.country_code
          )
          meeting.update(
            description: holiday["description"],
            calendar_id: calendar.id,
            company_id: company.id
          )
        end
      end
    end
  end

  def api_call(country_code, year)
    response = RestClient::Request.execute(
      method: :get,
      url: "https://calendarific.com/api/v2/holidays?&api_key=#{ENV['api_key']}&country=#{country_code}&year=#{year}"
    )
    JSON.parse(response)
  end

end
