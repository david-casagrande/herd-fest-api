require 'test_helper'

describe Venue do
  let(:band) { Fabricate(:band) }
  let(:set_time) { Fabricate(:set_time, venue: subject, band: band) }

  subject { Fabricate(:venue) }

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

  describe 'bands' do
    before do
      set_time
    end

    it 'has many bands through set times' do
      assert_equal(1, subject.bands.count)
      assert_equal(band, subject.bands.first)
    end
  end
end
