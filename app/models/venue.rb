class Venue < ActiveRecord::Base
  has_many :set_times, dependent: :destroy
  has_many :bands, through: :set_times
end
