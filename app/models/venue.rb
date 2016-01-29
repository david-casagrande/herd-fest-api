class Venue < ActiveRecord::Base
  include Cache

  has_many :set_times, dependent: :destroy
  has_many :bands, through: :set_times

  validates :name, presence: true
  validates :street_address, presence: true
end
