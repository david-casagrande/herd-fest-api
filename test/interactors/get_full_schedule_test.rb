require 'test_helper'

describe GetFullSchedule do
  let(:band) { Fabricate(:band) }
  let(:day) { Fabricate(:day) }
  let(:venue) { Fabricate(:venue) }
  let(:set_time) { Fabricate(:set_time, band: band, venue: venue, day: day) }
  let(:expected) do
    {
      bands: BandSerializer.new(Band.all),
      days: DaySerializer.new(Day.all),
      venues: VenueSerializer.new(Venue.all),
      set_times: SetTimeSerializer.new(SetTime.all)
    }
  end

  subject { GetFullSchedule }

  before do
    band
    day
    venue
    set_time
  end

  describe 'when fresh argument is set to true' do
    it 'always retrieves records from db' do
      assert_equal(subject.call(fresh: true).result.to_json, expected.to_json)
    end
  end

  describe 'there are no cached records' do
    it 'retrieves records from db' do
      assert_equal(subject.call.result.to_json, expected.to_json)
    end
  end

  describe 'there are cached records' do
    let(:data) do
      {
        test: []
      }
    end

    before do
      CacheStore.create(data: data)
    end

    it 'retrieves the cached json' do
      assert_equal(subject.call.result.to_json, data.to_json)
    end
  end
end
