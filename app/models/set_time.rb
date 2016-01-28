class SetTime < ActiveRecord::Base
  include Cache

  belongs_to :band
  belongs_to :venue
end
