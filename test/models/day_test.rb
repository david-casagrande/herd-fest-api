require 'test_helper'

describe Day do
  subject { Fabricate(:day) }

  it 'exists' do
    assert subject.valid? true
  end
end
