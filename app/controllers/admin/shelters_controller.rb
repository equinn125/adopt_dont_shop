class Admin::SheltersController < ApplicationsController

  def index
    @shelters = Shelter.reverse_order
  end
end
