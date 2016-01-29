require 'test_helper'

describe CacheFullSchedule do
  subject { CacheFullSchedule }

  it 'creates a json file of the returned results' do
    made_dir = false
    mkdir = lambda do |_directory|
      made_dir = true
    end

    mock = MiniTest::Mock.new
    json = { test: 'hey' }
    mock.expect(:write, nil, [json.to_json])

    full_schedule = MiniTest::Mock.new
    full_schedule.expect(:result, json)

    File.stub(:directory?, false) do
      Dir.stub(:mkdir, mkdir) do
        GetFullSchedule.stub(:call, full_schedule) do
          File.stub(:open, nil, mock) do
            full_schedule = subject.call
            assert(made_dir)
            assert(full_schedule.success?)
          end
        end
      end
    end

    assert mock.verify
  end

  it 'deletes file if it exists on error' do
    directory_lambda = lambda do |_directory|
      fail StandardError, 'Failure'
    end

    delete_file = false
    mkdir = lambda do |_directory|
      delete_file = true
    end

    File.stub(:directory?, directory_lambda) do
      File.stub(:exist?, true) do
        File.stub(:delete, mkdir) do
          subject.call
          assert(delete_file)
        end
      end
    end
  end
end
