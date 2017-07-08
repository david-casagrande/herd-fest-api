class CacheStore < ApplicationRecord
  def self.latest
    order(created_at: :desc).limit(1).first
  end
end
