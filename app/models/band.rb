class Band < ActiveRecord::Base
  has_many :set_times, dependent: :destroy
  has_many :venues, through: :set_times
end
