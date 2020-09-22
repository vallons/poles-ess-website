class TimeRange < Range

  def initialize(begin_datetime, end_datetime = nil, exclude_end = true)
    range_begin = if begin_datetime.is_a?(String)
      Time.zone.parse(begin_datetime)
    else
      begin_datetime
    end

    range_end = if end_datetime.is_a?(String)
      Time.zone.parse(end_datetime)
    else
      end_datetime
    end

    super range_begin, range_end, exclude_end
  end
end
