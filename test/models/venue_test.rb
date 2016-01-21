require 'test_helper'

describe Venue do
  subject { Fabricate(:venue) }

  it 'exists' do
    assert subject.valid? true
  end
end
