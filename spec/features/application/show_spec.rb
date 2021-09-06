require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @app = Application.create!(name: 'Erin',
      address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip: 80127,
      reason: 'I like dogs',
      status: 'In Progress'
      )
      @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: 'Henry', age:1, breed: 'Corgi', adoptable: true)
      @pet_2 = @shelter.pets.create!(name: 'Taz', age:4, breed: 'Mutt', adoptable: true)
      ApplicationPet.create!(pet: @pet_1, application: @app)

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
    @app.pets << @pet_1
    @app.pets << @pet_2
     visit "/applications/#{@app.id}"
     expect(page).to have_link("#{@pet_1.name}")
     expect(page).to have_link("#{@pet_2.name}")
  end

  it 'has a text box to search for specific pets is app has NOT been submitted' do
    visit "/applications/#{@app.id}"
    expect(page).to have_content('In Progress')
    expect(page).to have_button("Search")
  end

  it 'can list search results for a pet name' do
    visit "/applications/#{@app.id}"
    fill_in 'Search', with: 'Henry'
    click_button('Search')
    expect(page).to have_content(@pet_1.name)
  end

  it 'has a button to adopt this pet' do
    visit "/applications/#{@app.id}"
    fill_in 'Search', with: "#{@pet_1.name}"
    click_button('Search')
    expect(page).to have_button('Adopt This Pet')

    within "#pet-#{@pet_1.id}" do
      click_button "Adopt This Pet"
    end
    expect(page).to have_link("#{@pet_1.name}")
    expect(current_path).to eq("/applications/#{@app.id}") 
  end
end
