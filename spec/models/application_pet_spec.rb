require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :application}
    it { should belong_to :pet}
  end

  it 'finds the application for the applicaitonpet' do
    app_1 = Application.create!(name: 'Erin',
      address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip: 80127,
      reason: 'I like dogs',
      status: 'Pending'
      )
      app_2 = Application.create!(name: 'Nick',
        address: '123 Main Street',
        city: 'Denver',
        state: 'CO',
        zip: 80127,
        status: 'Pending'
        )
      shelter_1 = Shelter.create!(name: 'Building', city: 'Irvine CA', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: 'Henry', age:1, breed: 'Corgi', adoptable: true)
      pet_2 = shelter_2.pets.create!(name: 'Taz', age:4, breed: 'Mutt', adoptable: true)
      app_pet_1 = ApplicationPet.create!(pet: pet_1, application: app_1)
      app_pet_2 = ApplicationPet.create!(pet: pet_1, application: app_2)

    expect(ApplicationPet.find_app(app_1.id, pet_1.id)).to eq(app_pet_1)
  end
end
