require 'rails_helper'

RSpec.describe "Admin Shelter Index Page" do
  before :each do
    @app_1 = Application.create!(name: 'Erin',
      address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip: 80127,
      reason: 'I like dogs',
      status: 'In Progress'
      )
      @app_2 = Application.create!(name: 'Nick',
        address: '123 Main Street',
        city: 'Denver',
        state: 'CO',
        zip: 80127,
        status: 'In Progress'
        )
      @shelter_1 = Shelter.create!(name: 'Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create!(name: 'Henry', age:1, breed: 'Corgi', adoptable: true)
      @pet_2 = @shelter_2.pets.create!(name: 'Taz', age:4, breed: 'Mutt', adoptable: true)
      ApplicationPet.create!(pet: @pet_1, application: @app_1)
  end

  it 'has shelter names sorted in reverse alphabetical order' do
    visit "/admin/shelters"
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
  end
end
