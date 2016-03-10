class RouteReference

  include ActiveModel::Model

  attr_accessor :start_point,  :goal_point

  def initialize(params)
    self.start_point = params[:start_point].to_i
    self.goal_point = params[:goal_point].to_i
  end

  def prepare_routes
    track = track_build(start_point, goal_point)
    tracks = {}
    tracks[0] = track if track
    neighbor_nodes(start_point).each do |start_node|
      start_track = track_build(start_point, start_node)
      neighbor_nodes(goal_point).each do |goal_node|
        if start_node == goal_node
          route_array = []
          track_between_nodes = []
          route_array.push([goal_node])
          track_between_nodes.push(track_build(goal_node, goal_point)).uniq
          total_track = (start_track + track_between_nodes).flatten.uniq
          route_array.push(total_track)
          tracks[goal_point] = route_array
        else
          PossibleWay.where(point_id: start_node, target_point: goal_node).each do |node_track|
            node_track_array = string_to_array(node_track.track_array)
            unless repeat_track?(node_track_array, goal_point)
              track = []
              route_array = []
              route_array.push(string_to_array(node_track.track_array))
              track_between_nodes = []
              (1..node_track_array.count-1).each do |i|
                  track_between_nodes.push(track_build(node_track_array[i - 1], node_track_array[i]))
              end
              track_between_nodes.push(track_build(goal_node, goal_point)).uniq if goal_node != goal_point
              total_track = (start_track + track + track_between_nodes).flatten.uniq
              route_array.push(total_track)
              tracks[node_track.id] = route_array
            end
          end
        end
      end
    end
    tracks
  end

  protected

  def nodes_in_route(point_id)
    route_id = Shedule.where(point_id: point_id).first.route_id
    nodes = []
    Node.pluck(:point_id).each do |id|
      nodes.push(id) if Shedule.where(point_id: id).pluck(:route_id).include?(route_id)
    end
    nodes
  end

  def track_build(start_point, goal_point)
    track = go_round_neighbors(start_point, goal_point)
    if track != [] && track.include?(goal_point)

      track
    else
      track = go_round_points(start_point, goal_point)
      if track != [] && track.include?(goal_point)
        track
      end
    end
  end

  def belongs_to_same_rout?(current_point, goal_point)
    routes = Shedule.where(point_id: goal_point).pluck(:route_id)
    routes.include?(Shedule.where(point_id: current_point).first.route_id)
  end

  def go_round_neighbors(neighbor, goal_point)
    track = [neighbor]
    if is_a_node?(neighbor)
      neighbors = Distance.where(neighbor_id: neighbor).pluck(:point_id)
      neighbors.each do |n|
        if belongs_to_same_rout?(n, goal_point)
          neighbor = n
          track.push(neighbor)
          neighbor = Distance.where(neighbor_id: neighbor).first.point_id
          while criterion_neighbor(neighbor) && neighbor != goal_point
            track.push(neighbor)
            neighbor = Distance.where(neighbor_id: neighbor).first.point_id
          end
          track.push(neighbor)
        end
      end
    else
      while criterion_neighbor(neighbor) && neighbor != goal_point
        neighbor = Distance.where(neighbor_id: neighbor).first.point_id
        track.push(neighbor)
      end
    end
    track
  end

  def go_round_points(point, goal_point)
    track = [point]
    if is_a_node?(point)
      points = Distance.where(point_id: point).pluck(:neighbor_id)
      points.each do |p|
        if belongs_to_same_rout?(p, goal_point)
          point = p
          track.push(point)
          point = Distance.where(point_id: point).first.neighbor_id
          while criterion_point(point) && point != goal_point
            track.push(point)
            point = Distance.where(point_id: point).first.neighbor_id
          end
          track.push(point)
        end
      end
    else
      while criterion_point(point) && point != goal_point
        point = Distance.where(point_id: point).first.neighbor_id
        track.push(point)
      end
    end
    track
  end

  def point_position_array(point_id)
    route_id = Shedule.where(point_id: point_id).first.route_id
    points_array = Shedule.where(route_id: route_id).pluck(:point_id)
    array = []
    points_array.each do |point|
      if point == point_id or nodes_in_route(point).include?(point)
        array.push(point)
      end
    end
    array
  end

  def neighbor_nodes(point)
    array = point_position_array(point)
    if !Node.where(point_id: point).blank?
      start_nodes_array = [point]
    else
      if array.first == point
        start_nodes_array = [array[1]]
      elsif array.last == point
        start_nodes_array = [array[-2]]
      else
        index = array.index(point)
        start_nodes_array = [ array[index - 1], array[index + 1] ]
      end
    end
  end

  def criterion_point(point)
    if is_a_node?(point)
      false
    else
      if is_first?(point)
        false
      else
        true
      end
    end
  end

  def criterion_neighbor(neighbor)
    if is_a_node?(neighbor)
      false
    else
      if is_last?(neighbor)
        false
      else
        true
      end
    end
  end

  def is_first?(point)
   first = Shedule.where(point_id: point).first.first_point
  end

  def is_last?(neighbor)
    last = Shedule.where(point_id: neighbor).first.last_point
  end

  def is_a_node?(point)
   node = Distance.where(point_id: point).count > 1
  end

  def repeat_track?(node_track_array, goal_point)
    array_start = [node_track_array[0], node_track_array[1]]
    array_goal = [node_track_array[-2], node_track_array[-1]]
    nodes_start = neighbor_nodes(start_point)
    nodes_goal = neighbor_nodes(goal_point)
    no_repeat_start = array_start.include?(nodes_start[0]) & array_start.include?(nodes_start[1])
    no_repeat_goal = array_goal.include?(nodes_goal[0]) & array_goal.include?(nodes_goal[1])
    no_repeat_start | no_repeat_goal
  end

  def string_to_array(string)
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
