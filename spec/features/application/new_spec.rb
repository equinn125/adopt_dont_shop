require 'rails_helper'

RSpec.describe 'start a application' do
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
      end
    end
  end
end
