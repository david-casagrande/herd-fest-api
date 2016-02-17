module API
  class DaysController < APIController
    def index
      respond_with serialized_days
    end

    private

    def serialized_days
      @serialized_days ||= DaySerializer.new(days)
    end

    def days
      @days ||= Day.all.includes(:set_times, :bands, :venues)
    end
  end
end
