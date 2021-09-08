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
        status: 'Pending'
        )
      @shelter_1 = Shelter.create!(name: 'Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create!(name: 'Henry', age:1, breed: 'Corgi', adoptable: true)
      @pet_2 = @shelter_2.pets.create!(name: 'Taz', age:4, breed: 'Mutt', adoptable: true)
      @app_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @app_1)
      @app_pet_2 = ApplicationPet.create!(pet: @pet_1, application: @app_2)
  end

  it 'allows me to approve a application' do
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

  it 'allows me to reject a application' do
    visit "/admin/applications/#{@app_1.id}"
    expect(page).to have_button("Reject")
    within "#pet-#{@pet_1.id}" do
      click_button("Reject")
      expect(page).to have_content("#{@pet_1.name} Rejected")
      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
    end
  end

  it 'does not interfear with other applications' do
    visit "/admin/applications/#{@app_1.id}"
    within "#pet-#{@pet_1.id}" do
      click_button("Approve")
    end

    visit "/admin/applications/#{@app_2.id}"
    within "#pet-#{@pet_1.id}" do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end
end
