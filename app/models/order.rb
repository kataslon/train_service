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
      route_defining(route_part[0], route_part[1])
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
    (0..array.count-2).each do |i|
        part_points = []
        part_points.push(string_to_array(nodes_array)[i])
        part_points.push(string_to_array(nodes_array)[i + 1])
        route_parts_array.push(part_points)
    end
    if nodes_array.last != track_array.last
      part_points = []
      part_points.push(string_to_array(nodes_array).last)
      part_points.push(string_to_array(track_array).last)
      route_parts_array.push(part_points)
    end
    route_parts_array
  end

  def route_shedule(point_array)
    # byebug
    route_id = route_defining(point_array[0], point_array[1])[0]
    # current_point = Shedule.where(route_id: route_id, first_point: true).first.point_id
    current_point = point_array[0]
    route_shedule = {}
    next_point = current_point
    point_data = {}
    point_data[:name] = Point.find(current_point).name
    total_distance = 0
    current_time = 0#Route.find(route_id).daparture
    point_data[:out_time] = current_time
    route_shedule[current_point] = point_data
    while next_point != point_array[1] && !Shedule.where(route_id: route_id, point_id: next_point).first.last_point
      point_data = {}
      # next_point = Distance.where(neighbor_id: current_point).first.point_id
      next_points = Distance.where(neighbor_id: current_point).pluck(:point_id)
      next_points.each do |id|
        if Shedule.where(point_id: id).first.route_id == route_id
          next_point = Point.find(id).id
        end
        next_point = id if id == point_array[1]
      end
      point_data[:name] = Point.find(next_point).name
      # byebug
      point_data[:distance] = Distance.where(neighbor_id: current_point, point_id: next_point).first.distance
      total_distance += point_data[:distance]
      point_data[:total_distance] = total_distance
      current_time = point_data[:distance] / Route.find(route_id).speed
      point_data[:in_time] = current_time
      point_data[:breack] = Shedule.where(point_id: next_point, route_id: route_id).first.breack
      # current_time += point_data[:breack] if point_data[:breack] != nil
      point_data[:out_time] = current_time
      route_shedule[next_point] = point_data
      current_point = next_point
    end
    route_shedule
  end

  def route_defining(first_point, second_point)
    first_route_id_array = Shedule.where(point_id: first_point).pluck(:route_id)
    second_route_id_array = Shedule.where(point_id: second_point).pluck(:route_id)
    first_route_id_array & second_route_id_array
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
    string = string.split(" ")
    array = []
    string.each do |l|
      array.push(l.to_i)
    end
    array
  end

end
