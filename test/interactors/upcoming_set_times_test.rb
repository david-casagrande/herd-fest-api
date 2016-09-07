require 'test_helper'

describe UpcomingSetTimes do
  include ActiveSupport::Testing::TimeHelpers

  let(:day_1) { Fabricate(:day, date: '2016-06-11') }
  let(:day_2) { Fabricate(:day, date: '2016-06-12') }
  let(:day_3) { Fabricate(:day, date: '2016-06-13') }

  it 'gets all set times starting in the next 10 minutes' do
    travel_to Time.zone.parse('2016-06-12').noon do
      st_1 = Fabricate(:set_time, start_time: 5.minutes.ago, day: day_2)
      st_2 = Fabricate(:set_time, start_time: Time.current, day: day_2)
      st_3 = Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_2)
      st_4 = Fabricate(:set_time, start_time: 10.minutes.from_now, day: day_2)
      Fabricate(:set_time, start_time: 11.minutes.from_now, day: day_2)
      Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_1)
      Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_3)

      d_1 = Fabricate(:device, schedule: [st_1.id, st_3.id])
      d_2 = Fabricate(:device, schedule: [st_2.id, st_3.id])
      d_3 = Fabricate(:device, schedule: [st_4.id, st_3.id])
      Fabricate(:device, schedule: [])

      calls = []
      send_notification = ->(context) { calls << context }

      SendNotification.stub(:call, send_notification) do
        UpcomingSetTimes.call

        assert_equal 2, calls.count

        assert_equal 3, calls[0][:devices].count
        assert_includes calls[0][:devices], d_1
        assert_includes calls[0][:devices], d_2
        assert_includes calls[0][:devices], d_3
        assert_equal "#{st_3.band.name} is on in 5 minutes @ #{st_3.venue.name}.", calls[0][:message]

        assert_equal 1, calls[1][:devices].count
        assert_includes calls[1][:devices], d_3
        assert_equal "#{st_4.band.name} is on in 10 minutes @ #{st_4.venue.name}.", calls[1][:message]
      end
    end
  end

  it 'gets all set times starting in the next 10 minutes between xx:55 - xx:05' do
    travel_to Time.zone.parse('2016-06-12').noon - 5.minutes do
      st_1 = Fabricate(:set_time, start_time: 5.minutes.ago, day: day_2)
      st_2 = Fabricate(:set_time, start_time: Time.current, day: day_2)
      st_3 = Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_2)
      st_4 = Fabricate(:set_time, start_time: 10.minutes.from_now, day: day_2)
      Fabricate(:set_time, start_time: 11.minutes.from_now, day: day_2)
      Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_1)
      Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_3)

      d_1 = Fabricate(:device, schedule: [st_1.id, st_3.id])
      d_2 = Fabricate(:device, schedule: [st_2.id, st_3.id])
      d_3 = Fabricate(:device, schedule: [st_4.id, st_3.id])
      Fabricate(:device, schedule: [])

      calls = []
      send_notification = ->(context) { calls << context }

      SendNotification.stub(:call, send_notification) do
        UpcomingSetTimes.call

        assert_equal 2, calls.count

        assert_equal 3, calls[0][:devices].count
        assert_includes calls[0][:devices], d_1
        assert_includes calls[0][:devices], d_2
        assert_includes calls[0][:devices], d_3
        assert_equal "#{st_3.band.name} is on in 5 minutes @ #{st_3.venue.name}.", calls[0][:message]

        assert_equal 1, calls[1][:devices].count
        assert_includes calls[1][:devices], d_3
        assert_equal "#{st_4.band.name} is on in 10 minutes @ #{st_4.venue.name}.", calls[1][:message]
      end
    end
  end

  it 'gets all set times starting in the next 10 minutes at midnight' do
    travel_to Time.zone.parse('2016-06-13').midnight do
      st_1 = Fabricate(:set_time, start_time: 5.minutes.ago, day: day_2)
      st_2 = Fabricate(:set_time, start_time: Time.current, day: day_2)
      st_3 = Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_2)
      st_4 = Fabricate(:set_time, start_time: 10.minutes.from_now, day: day_2)
      Fabricate(:set_time, start_time: 11.minutes.from_now, day: day_2)
      Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_1)
      Fabricate(:set_time, start_time: 5.minutes.from_now, day: day_3)

      d_1 = Fabricate(:device, schedule: [st_1.id, st_3.id])
      d_2 = Fabricate(:device, schedule: [st_2.id, st_3.id])
      d_3 = Fabricate(:device, schedule: [st_4.id, st_3.id])
      Fabricate(:device, schedule: [])

      calls = []
      send_notification = ->(context) { calls << context }

      SendNotification.stub(:call, send_notification) do
        UpcomingSetTimes.call

        assert_equal 2, calls.count

        assert_equal 3, calls[0][:devices].count
        assert_includes calls[0][:devices], d_1
        assert_includes calls[0][:devices], d_2
        assert_includes calls[0][:devices], d_3
        assert_equal "#{st_3.band.name} is on in 5 minutes @ #{st_3.venue.name}.", calls[0][:message]

        assert_equal 1, calls[1][:devices].count
        assert_includes calls[1][:devices], d_3
        assert_equal "#{st_4.band.name} is on in 10 minutes @ #{st_4.venue.name}.", calls[1][:message]
      end
    end
  end
end
