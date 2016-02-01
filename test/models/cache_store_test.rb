require 'test_helper'

describe CacheStore do
  subject { CacheStore.create }

  it 'exists' do
    assert subject.valid? true
  end

  describe '.latest' do
    it 'grabs the latest record' do
      CacheStore.create
      CacheStore.create
      lastest = CacheStore.create
      assert_equal(CacheStore.latest, lastest)
    end

    it 'returns nil when there are no records' do
      assert_nil(CacheStore.latest)
    end
  end
end
