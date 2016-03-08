class Order < ActiveRecord::Base
  has_many :tickets
  accepts_nested_attributes_for :tickets, :allow_destroy => true

  def total_track
    total_track = []
    route_parts.each do |route_part|
      total_track.push(route_shedule(route_part))
    end
    total_track
  end

  def route_parts
    part_points = []
    route_parts_array = []
    part_points.push(string_to_array(track_array).first)
    part_points.push(string_to_array(nodes_array).first)
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
    track = reduce_array(string_to_array(track_array), point_array[0], point_array[1])
    route_id = route_defining(point_array[0], point_array[1])[0]
    route_shedule = {}
    total_distance = 0
    if Distance.where(point_id: track[0], neighbor_id: track[1]).first.blank?
      i, j = 1, 0
      total_time = Route.find(route_id).travel_time_left(point_array[0])
    else
      i, j = 0, 1
      total_time = Route.find(route_id).travel_time_right(point_array[0])
    end
    (0..track.count-2).each do |index|
      point_data = {}
      point_data[:name] = Point.find(track[index]).name
      point_data[:id] = track[index]
      point_data[:distance] = Distance.where(point_id: track[index + i], neighbor_id: track[index + j]).first.distance
      point_data[:total_distance] = total_distance
      total_distance += point_data[:distance]
      point_data[:in_time] = total_time
      point_data[:breack] = Shedule.where(point_id: track[index], route_id: route_id).first.breack
      total_time += point_data[:breack] if point_data[:breack] != nil
      point_data[:out_time] = total_time
      total_time += point_data[:distance].to_f / Route.find(route_id).speed.to_f * 3600
      point_data[:route_id] = route_id
      route_shedule[track[index]] = point_data
    end
    point_data = {}
    index = track.count - 1
    point_data[:name] = Point.find(track[-1]).name
    point_data[:id] = track[-1]
    point_data[:total_distance] = total_distance
    point_data[:in_time] = total_time
    point_data[:breack] = Shedule.where(point_id: track[index], route_id: route_id).first.breack
    route_shedule[track[index]] = point_data
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

  def string_to_array(string)
    string.delete! "["
    string.delete! "]"
    string = string.split(" ")
    array = []
    string.each do |l|
      array.push(l.to_i)
    end
    array
  end

  def reduce_array(array, first, second)
    while array[0] != first
      array.shift
    end
    while array[-1] != second
      array.pop
    end
    array
  end

end
