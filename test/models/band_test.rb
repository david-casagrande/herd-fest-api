require 'test_helper'

describe Band do
  subject { Band.new }

  it 'exists' do
    assert subject.valid? true
  end
end
