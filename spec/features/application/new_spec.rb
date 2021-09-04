require 'rails_helper'

RSpec.describe 'start a application' do

  it 'has a link to go to start an application' do
    visit "/pets"
    expect(page).to have_link("Start Application")
    click_link("Start Application")
    expect(current_path).to eq("/applications/new")
  end
  
  describe 'the application new' do
    it 'renders a new form' do
      visit '/applications/new'
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip')
    end
  end

  describe 'create application' do
    context 'valid info' do
      it 'creates the new application and redirects to the application show page' do
        visit '/applications/new'
        fill_in 'Name', with: 'Nick Miller'
        fill_in 'Address', with: '123 Main St.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CA'
        fill_in 'Zip', with: '80127'
        click_button 'Submit'
        expect(current_path).to eq("/applications/#{Application.last.id}")
        expect(page).to have_content('Nick Miller')
        expect(page).to have_content('123 Main St.')
        expect(page).to have_content('Denver')
        expect(page).to have_content('80127')
        expect(page).to have_content('In Progress')
      end
    end

    context "invlaid info" do
      it 're-renders the new applicatino form' do
        visit '/applications/new'

        fill_in 'Name', with: 'Jess Day'
        click_button "Submit"

        expect(page).to have_content("Error: Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank")
        expect(current_path).to eq("/applications/new")
      end
    end
  end
end
