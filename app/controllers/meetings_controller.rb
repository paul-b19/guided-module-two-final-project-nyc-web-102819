class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :set_type

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = type_class.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    @company = Company.find(@meeting.company_id)
    if @meeting.country_code
      @country = Timezone.find_by(code: @meeting.country_code).name
    else
      @country = nil
    end
    @session_company = Company.find(session[:the_company]).first
  end

  # GET /meetings/new
  def new
    @meeting = type_class.new
    @calendar = Calendar.find(session[:the_calendar])
  end

  # GET /meetings/1/edit
  def edit
    @meeting = type_class.find(params[:id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = type_class.new(meeting_params)
    @meeting.company_id = session[:the_company].first.to_i
    @meeting.calendar_id = session[:the_calendar]

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: "#{type.capitalize} event was successfully created." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: "#{type.capitalize} event was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting = Meeting.find(params[:id])
    calendar = @meeting.calendar
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to calendar_path(calendar), notice: "#{type.capitalize} event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_type 
    @type = type 
  end

  def type 
    Meeting.types.include?(params[:type]) ? params[:type] : "Meeting"
  end

  def type_class 
    type.constantize 
  end

  def set_meeting
    @meeting = type_class.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meeting_params
    params.require(type.underscore.to_sym).permit(
      :name,
      :type,
      :description,
      :start_time,
      :end_time,
      :country_code
    )
  end
  
end
