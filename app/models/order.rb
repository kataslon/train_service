class Order < ActiveRecord::Base

  def travel_time
    self.track.each do |point_id|
      total_break += Point.find(point_id).break
    end

    self.nodes
  end

  def time_between_points(start_point, finish_point)
    route_id = Shedule.where(point_id: point_id).first.route_id
    time = Distance.where(neighbor_id: point) / Route.find(route_id).speed
  end

  def total_distance
    track_points = self.track.pop
    track_points.each do |point|
      distance += Distance.where(neighbor_id: point).distance
    end
  end

  def reserve_tickets#(route_parts_array, date)
    route_parts.each do |route_part|
      first_route_id_array = Shedule.where(point_id: route_part[0]).pluck(:route_id)
      second_route_id_array = Shedule.where(point_id: route_part[0]).pluck(:route_id)
      route_id = (first_route_id_array | second_route_id_array)
      route_ticket(route_part[0], route_part[1], route_id, self.date)
    end
  end

  def route_parts#(track_array, nodes_array)
    part_points = []
    route_parts_array = []
    part_points.push(track_array.first.to_i)
    part_points.push(nodes_array.first.to_i)
    route_parts_array.push(part_points)
    array = string_to_array(nodes_array)
    array.each do |node|
      if node != array.last
        part_points = []
        part_points.push(node)
        part_points.push(array[array.index(node) + 1])
        route_parts_array.push(part_points)
      end
    end
    if nodes_array.last != track_array.last
      part_points = []
      part_points.push(nodes_array.last)
      part_points.push(track_array.last)
      route_parts_array.push(part_points)
    end
    route_parts_array
  end

  def route_ticket(start_point, finish_point, route_id, date)
    Ticket.create(start_point: start_point, finish_point: finish_point, route_id: route_id, route_round_date: date)
  end

  def tickets_availability(route_id, date)
    Route.places_count > Ticket.where(route_id: route_id, date: date).count
  end

  def tickets_cost

  end

  def string_to_array(string) #дублируется, вынести в отдельный модуль
    string.delete! "["
    string.delete! "]"
    string = string.split(", ")
    array = []
    string.each do |l|
      array.push(l.to_i)
    end
    array
  end

end
