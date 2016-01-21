require 'test_helper'

describe Band do
  subject { Fabricate(:band) }

  it 'exists' do
    assert subject.valid? true
  end
end
