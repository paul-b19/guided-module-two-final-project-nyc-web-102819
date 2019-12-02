class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @companies = Company.all
    @company = Company.find(params[:id])
    @timezone_data = Timezone.all
    @partnership = Partnership.new

    session[:the_company] ||= []
    session[:the_company] << params[:id]
    session[:partners] ||= []
    session[:partners] << params[:id]
  end

  def new
    @company = Company.new
    @timezone_data = Timezone.all
  end



end