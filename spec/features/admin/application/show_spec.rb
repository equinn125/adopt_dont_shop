require 'rails_helper'

RSpec.describe "admin app show page" do
  before :each do
    @app_1 = Application.create!(name: 'Erin',
      address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip: 80127,
      reason: 'I like dogs',
      status: 'Pending'
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
      @app_pet = ApplicationPet.create!(pet: @pet_1, application: @app_1)
      ApplicationPet.create!(pet: @pet_2, application: @app_1)
  end

  it 'shows me every pet the application is for ' do
    visit "/admin/applications/#{@app_1.id}"
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@app_1.name)
    expect(page).to have_button("Approve")
    within "#pet-#{@pet_1.id}" do
      click_button("Approve")
      expect(page).to have_content("#{@pet_1.name} Approved")
      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
    end
  end
end
