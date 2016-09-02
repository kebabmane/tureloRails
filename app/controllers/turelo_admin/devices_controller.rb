class TureloAdmin::DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    authorize current_user
    @devices = Device.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    respond_with(@devices)
  end

  def show
    authorize current_user
    respond_with(@device)
  end

  def new
    authorize current_user
    @device = Device.new
    respond_with(@device)
  end

  def create
    authorize current_user
    @device = Device.new(device_params)
    #we allow the id to be sent as a parameter when model created
    if device_params[:id]
      @device.id = device_params[:id]
    end
  end

  def edit
  end

  def destroy
    authorize current_user
    @device.destroy
    respond_with(@device)
  end

  private
    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params.require(:device).permit(:device_id, :device_guid, :device_os, :token, :registration_id, :id)
    end
end
