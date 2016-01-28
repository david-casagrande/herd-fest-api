require 'test_helper'

describe GetFullSchedule do
  let(:band) { Fabricate(:band) }
  let(:venue) { Fabricate(:venue) }
  let(:set_time) { Fabricate(:set_time, band: band, venue: venue) }
  let(:expected) do
    {
      bands: BandSerializer.new(Band.all),
      venues: VenueSerializer.new(Venue.all),
      set_times: SetTimeSerializer.new(SetTime.all)
    }
  end

  subject { GetFullSchedule }

  before do
    band
    venue
    set_time
  end

  describe 'when fresh argument is set to true' do
    it 'always retrieves records from db' do
      File.stub(:exists?, true) do
        assert_equal(subject.call(fresh: true).result.to_json, expected.to_json)
      end
    end
  end

  describe 'there is not a cached json file' do
    it 'retrieves records from db' do
      File.stub(:exists?, false) do
        assert_equal(subject.call(fresh: true).result.to_json, expected.to_json)
      end
    end
  end

  describe 'there is a cached json file' do
    let(:json) do
      {
        test: []
      }
    end

    it 'retrieves the cached json' do
      File.stub(:exists?, true) do
        File.stub(:read, json.to_json) do
          assert_equal(subject.call.result.to_json, json.to_json)
        end
      end
    end
  end
end
