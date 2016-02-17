require 'test_helper'

describe SetTimeSerializer do
  let(:model) { Fabricate(:set_time) }

  subject { SetTimeSerializer.new(model) }

  it 'includes id' do
    assert_equal(subject.to_hash[:id], model.id)
  end

  it 'includes start time' do
    assert_equal(subject.to_hash[:start_time], model.start_time)
  end

  it 'includes band' do
    assert_equal(subject.to_hash[:band], model.band.id)
  end

  it 'includes venue' do
    assert_equal(subject.to_hash[:venue], model.venue.id)
  end

  it 'includes venue' do
    assert_equal(subject.to_hash[:day], model.day.id)
  end
end
