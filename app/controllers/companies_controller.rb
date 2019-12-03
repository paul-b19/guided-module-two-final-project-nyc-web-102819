class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @country = Timezone.find_by(code: @company.country_code).name
    @calendars = @company.calendars.count > 0 ? @company.calendars : nil

    reset_session
    session[:the_company] ||= []
    session[:the_company].push(params[:id]) unless session[:the_company].include?(params[:id])
    session[:partners] ||= []
    session[:partners].push(params[:id]) unless session[:partners].include?(params[:id])
  end

  def new
    @company = Company.new
    @countries = Timezone.group(:name)
    @timezones = Timezone.group(:zone)
  end

  def create
    company = Company.new(company_params)
    company.save
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :description,
      :country_code,
      :time_zone_offset,
      :work_days,
      :open_time,
      :close_time
    )
  end

end
