class Application < ApplicationRecord
  has_many :application_pets, dependent: :delete_all
  has_many :pets, through: :application_pets
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
