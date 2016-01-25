require 'test_helper'

describe 'BaseSerializer' do
  class SubClass < BaseSerializer
    def serialize(model)
      {
        id: model.id
      }
    end
  end

  let(:model1) { Fabricate(:band) }
  let(:expected) do
    {
      id: model1.id
    }
  end

  describe 'with single record' do
    subject { SubClass.new(model1) }

    it 'returns a single object as definined in #serialize when #to_hash is called' do
      assert_equal(subject.to_hash, expected)
    end

    it 'returns json version of to_hash when to_json is called' do
      assert_equal(subject.to_json, expected.to_json)
    end
  end

  describe 'with a collection of records' do
    subject { SubClass.new([model1]) }

    it 'returns an array of objects as definined in #serialize when #to_hash is called' do
      assert_equal(subject.to_hash, [expected])
    end

    it 'returns json version of to_hash when to_json is called' do
      assert_equal(subject.to_json, [expected].to_json)
    end
  end
end
