class CacheFullSchedule
  include Interactor

  def call
    cache
  rescue StandardError => e
    context.fail!(error: e)
  end

  private

  def data
    @data ||= GetFullSchedule.call(fresh: true)
  end

  def cache
    @cache ||= CacheStore.create(data: data.result)
  end
end
