class CalendarsController < ApplicationController

  def show
    @calendar = Calendar.find(params[:id])
    @meetings = Meeting.all
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
    redirect_to calendar_path(@calendar)
  end

  def add_holidays
    # API call for each of the companies in session[:partners]
  end

end
