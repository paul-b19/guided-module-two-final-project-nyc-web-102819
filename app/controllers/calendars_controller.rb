class CalendarsController < ApplicationController
  require 'json'

  def show
    @calendar = Calendar.find(params[:id])
    @meetings = Meeting.where(calendar_id: @calendar.id)
    session[:the_calendar] = @calendar.id
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
    @calendar = Calendar.create
    partners = session[:partners]
    partners.each do |partner|
      @partnership = Partnership.create(company_id: partner, calendar_id: @calendar.id)
    end
    names = @calendar.companies.pluck(:name).join('|')
    @calendar.update(name: "Calendar for #{names}")
    #byebug
    add_holidays
    redirect_to calendar_path(@calendar)
  end

  def add_holidays
    partners = session[:partners]
    partners.each do |company_id|
      country_code = Company.find(company_id).country_code
      hash = api_call(country_code)
      hash["response"]["holidays"].each do |holiday|
        if holiday["type"].first == "National holiday"
          m = Meeting.find_or_create_by(
            name: holiday["name"],
            type: "Holiday",
            start_time: "#{holiday["date"]["iso"]} 00:00:00",
            end_time: "#{holiday["date"]["iso"]} 23:59:00"
          )
          m.update(
            description: holiday["description"],
            calendar_id: @calendar.id,
            company_id: company_id.to_i
          )
        end
      end
    end
  end

  # def add_holidays
  #   partners = session[:partners]
  #   partners.each do |company_id|
  #     country_code = Company.find(company_id).country_code
  #     hash = api_call(country_code)
  #     hash["response"]["holidays"].each do |holiday|
  #       if holiday["type"].first == "National holiday"
  #         Meeting.find_or_create_by(
  #           name: holiday["name"],
  #           type: "Holiday",
  #           description: holiday["description"],
  #           calendar_id: @calendar.id,
  #           company_id: company_id.to_i,
  #           start_time: "#{holiday["date"]["iso"]} 00:00:00",
  #           end_time: "#{holiday["date"]["iso"]} 23:59:00"
  #         )
  #       end
  #     end
  #   end
  # end

  def api_call(country_code)
    response = RestClient::Request.execute(
      method: :get,
      url: "https://calendarific.com/api/v2/holidays?&api_key=#{ENV['api_key']}&country=#{country_code}&year=2019"
    )
    # sleep 10
    JSON.parse(response)
  end

  # def api_call(country_code)
  #   response = RestClient::Request.execute(
  #     method: :get,
  #     url: 'https://calendarific.com/api/v2/holidays',
  #     headers: {
  #       api_key: '823747516d829b140ef9807ad001d167526c64bf',
  #       # ENV['API_KEY'],
  #       country: country_code,
  #       year: 2019 }
  #   )
  #   JSON.parse(response)
  # end

end
