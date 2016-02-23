require 'test_helper'

describe BandSerializer do
  let(:model) { Fabricate(:band) }
  let(:set_time) { Fabricate(:set_time, band: band) }

  subject { BandSerializer.new(model) }

  it 'includes id' do
    assert_equal(subject.to_hash[:id], model.id)
  end

  it 'includes name' do
    assert_equal(subject.to_hash[:name], model.name)
  end

  it 'includes image_url ids' do
    assert_equal(subject.to_hash[:image_url], model.image_url)
  end

  it 'includes description' do
    assert_equal(subject.to_hash[:description], model.description)
  end

  it 'includes set time ids' do
    assert_equal(subject.to_hash[:set_times], model.set_times.map(&:id))
  end
end
