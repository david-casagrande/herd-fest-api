module Cache
  extend ActiveSupport::Concern

  included do
    after_create :cache
    after_save :cache
    after_destroy :cache
  end

  private

  def cache
    fail Rails.env.inspect
    return if Rails.env == 'test'
    CacheFullSchedule.call
  end
end
