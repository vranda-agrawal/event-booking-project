class EventsController < ApplicationController
  load_and_authorize_resource
  before_action :set_event, only: %i[ show edit update destroy ]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
    end
  end

  def enrol
    if Enrol.create(user_id:current_user.id,event_id:params[:id])
      flash[:message]=["Successfully enrolled in an event"]
    else
      flash[:message]=["Successfully enrolled in an event"]
    end
    redirect_to events_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_name, :description, :event_date, :event_time, :price, :user_id)
    end
end
