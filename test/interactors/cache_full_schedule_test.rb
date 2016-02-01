require 'test_helper'

describe CacheFullSchedule do
  let(:band) { Fabricate(:band) }
  let(:venue) { Fabricate(:venue) }
  let(:set_time) { Fabricate(:set_time, band: band, venue: venue) }

  subject { CacheFullScheduleDB }

  before do
    band
    venue
    set_time
  end

  it 'creates a record in cache store of results from GetFullScheduleDB' do
    expected = GetFullScheduleDB.call(fresh: true)
    subject.call
    assert_equal(CacheStore.first.data.to_json, expected.result.to_json)
  end
end
