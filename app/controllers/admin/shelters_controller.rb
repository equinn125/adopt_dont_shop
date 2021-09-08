class Admin::SheltersController < ApplicationsController

  def index
    @shelters = Shelter.reverse_order
    @shelter_pending = Shelter.pending_app
  end
end
