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

end
