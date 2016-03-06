module ApplicationHelper

  def route_points(route)
    if route.is_a?(Array)
      route.map { |e| e = Point.find(e).name }
    else
      Point.find(route).name
    end
  end

  def point_name(id)
    Point.find(id).name
  end

  def minutes(seconds)
    if seconds != nil
      minutes = seconds / 60
      "#{minutes} мин"
    end
  end

  def time(time_utc)
    if time_utc != nil
      time_utc.strftime("%H:%M")
    end
  end

end
