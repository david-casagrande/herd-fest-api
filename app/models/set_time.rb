class SetTime < ApplicationRecord
  include Cache

  default_scope { order(:start_time) }
  scope :active, -> { joins(:day, :band).where(days: { active: true }, bands: { active: true }) }

  belongs_to :band
  belongs_to :venue
  belongs_to :day

  validates :band, presence: true
  validates :venue, presence: true
  validates :day, presence: true
end
