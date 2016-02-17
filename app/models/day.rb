class Day < ActiveRecord::Base
  include Cache

  validates :name, presence: true
  validates :date, presence: true

  has_many :set_times, dependent: :destroy
  has_many :bands, through: :set_times
  has_many :venues, through: :set_times
end
