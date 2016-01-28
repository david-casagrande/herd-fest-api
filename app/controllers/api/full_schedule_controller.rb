module API
  class FullScheduleController < APIController
    def index
      fail schedule.error if schedule.failure?
      respond_with schedule.result
    end

    private

    def schedule
      GetFullSchedule.call
    end
  end
end
