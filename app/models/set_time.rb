class SetTime < ActiveRecord::Base
  include Cache

  belongs_to :band
  belongs_to :venue

  validates :band, presence: true
  validates :venue, presence: true
end
