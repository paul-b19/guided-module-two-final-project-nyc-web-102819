class CalendarsController < ApplicationController

  def show

  end

  def add_partner
    session[:partners] << params[:id]
  end

  def new
    @calendar = Calendar.new
    @companies = Company.all
    @company = Company.find(session[:the_company].first)
    byebug
  end

  def create

  end

  private

  def calendar_params
    params.require(:calendar).permit()
  end

end