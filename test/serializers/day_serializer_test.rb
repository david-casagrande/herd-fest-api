require 'test_helper'

describe DaySerializer do
  let(:model) { Fabricate(:day) }
  let(:band) { Fabricate(:band) }
  let(:venue) { Fabricate(:venue) }
  let(:set_time) { Fabricate(:set_time, day: subject, band: band, venue: venue) }

  subject { DaySerializer.new(model) }

  it 'includes id' do
    assert_equal(subject.to_hash[:id], model.id)
  end

  it 'includes name' do
    assert_equal(subject.to_hash[:name], model.name)
  end

  it 'includes date' do
    assert_equal(subject.to_hash[:date], model.date)
  end

  it 'includes band ids' do
    assert_equal(subject.to_hash[:bands], model.bands.map(&:id))
  end

  it 'includes venue ids' do
    assert_equal(subject.to_hash[:venues], model.venues.map(&:id))
  end

  it 'includes set time ids' do
    assert_equal(subject.to_hash[:set_times], model.set_times.map(&:id))
  end
end
