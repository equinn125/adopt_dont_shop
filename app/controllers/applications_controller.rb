class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)
    application.status = "In Progress"
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
