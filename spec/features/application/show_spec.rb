require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @app = Application.create!(name: 'Erin',
      address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip: 80127,
      reason: 'I like dogs',
      status: 'Approved'
      )
      @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @pet = @shelter.pets.create!(name: 'Henry', age:1, breed: 'Corgi', adoptable: true)
      @app.pets << @pet
  end
  it 'shows the application and its attributes ' do
    visit "/applications/#{@app.id}"

      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.address)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zip)
      expect(page).to have_content(@app.reason)
      expect(page).to have_content(@app.status)
  end

  it 'has a link to the pet show page of each pet the applicant has applied for' do
     visit "/applications/#{@app.id}"
     expect(page).to have_link("#{@pet.name}")
  end
end
