class CalendarsController < ApplicationController

  def show
    @calendar = Calendar.find(params[:id])
  end

  def add_partner
    session[:partners] << params[:id]
  end

  def new
    @calendar = Calendar.new
    @companies = Company.all
    # @company = Company.find(session[:the_company])
    # byebug
  end

  def create
    @calendar = Calendar.new
  end

  private

  def calendar_params
    params.require(:calendar).permit()
  end

end