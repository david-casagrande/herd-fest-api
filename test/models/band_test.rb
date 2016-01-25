require 'test_helper'

describe Band do
  let(:venue) { Fabricate(:venue) }
  let(:set_time) { Fabricate(:set_time, band: subject, venue: venue) }

  subject { Fabricate(:band) }

  it 'exists' do
    assert_equal(true, subject.valid?)
  end

  describe 'set times' do
    before do
      set_time
    end

    it 'has many set times' do
      assert_equal(1, subject.set_times.count)
    end

    it 'destroys set time when it is destroyed' do
      expected = SetTime.all.count - 1

      subject.destroy!
      assert_equal(expected, SetTime.all.count)
    end
  end

  describe 'venues' do
    before do
      set_time
    end

    it 'has many venues through set times' do
      assert_equal(1, subject.venues.count)
      assert_equal(venue, subject.venues.first)
    end
  end
end
