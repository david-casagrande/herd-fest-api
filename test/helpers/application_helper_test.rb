require 'test_helper'

describe ApplicationHelper do
  let(:band) { Fabricate(:band) }
  let(:venue) { Fabricate(:venue) }
  let(:set_time) { Fabricate(:set_time, band: band, venue: venue) }

  describe 'set_time_for' do
    describe 'there is a set time for the given band at the given venue' do
      before do
        set_time
      end

      it 'returns array with the set time' do
        assert_equal(set_time_for(band, venue), [set_time])
      end
    end

    describe 'there is not a set time for the given band at the given venue' do
      it 'returns empty array' do
        assert_equal(set_time_for(band, venue), [])
      end
    end
  end
end
