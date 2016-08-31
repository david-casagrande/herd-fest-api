require 'test_helper'

describe Device do
  subject { Fabricate(:device) }

  it 'exists' do
    assert subject.valid? true
  end
end
