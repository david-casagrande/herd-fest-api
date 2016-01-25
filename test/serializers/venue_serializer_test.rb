require 'test_helper'

describe 'VenueSerializer' do
  let(:model) { Fabricate(:venue) }
  let(:set_time) { Fabricate(:set_time, band: band) }

  subject { VenueSerializer.new(model) }

  it 'includes id' do
    assert_equal(subject.to_hash[:id], model.id)
  end

  it 'includes name' do
    assert_equal(subject.to_hash[:name], model.name)
  end

  it 'includes street address' do
    assert_equal(subject.to_hash[:street_address], model.street_address)
  end

  it 'includes set times as ids' do
    assert_equal(subject.to_hash[:set_times], model.set_times.map(&:id))
  end

  it 'includes bands as ids' do
    assert_equal(subject.to_hash[:bands], model.bands.map(&:id))
  end
end
