class SetTime < ActiveRecord::Base
  include Cache

  default_scope { order(:start_time) }

  belongs_to :band
  belongs_to :venue
  belongs_to :day

  validates :band, presence: true
  validates :venue, presence: true
  validates :day, presence: true
end
