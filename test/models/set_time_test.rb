require 'test_helper'

describe SetTime do
  subject { Fabricate(:set_time) }

  it 'exists' do
    assert subject.valid? true
  end
end
