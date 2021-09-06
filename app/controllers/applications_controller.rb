class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    application.status = "In Progress"
    if  application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    app = Application.find(params[:id])
    app.status = "Pending"
    app.update(application_params)
    redirect_to "/applications/#{app.id}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :reason)
  end
end
