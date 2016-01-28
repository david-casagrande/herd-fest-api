module API
  class SetTimesController < APIController
    def index
      respond_with serialized_set_times
    end

    private

    def serialized_set_times
      @serialized_set_times ||= SetTimeSerializer.new(set_times)
    end

    def set_times
      @set_times ||= SetTime.all.includes(:band, :venue)
    end
  end
end
