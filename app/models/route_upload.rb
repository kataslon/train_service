class RouteUpload < ActiveRecord::Base
  belongs_to :route

  mount_uploader :route_file, RouteFileUploader

  attr_accessor :route_id

   # after :store, :create_routes
   before_save :create_routes

  protected

    def create_routes
      file = self.route_file
      content = CSV.parse(File.read("#{Rails.root}/public#{file.url}"))
      file_mapper(content, self.route_id)
      choose_nodes
      possible_ways
    end

    def file_mapper(content, route_id)
      clean_old_shedules(route_id)
      if Point.where(name: content[0][0]).blank?
        neighbor = Point.create(name: content[0][0])
      else
        neighbor = Point.where(name: content[0][0]).first
      end
      Shedule.create(point_id: neighbor.id, route_id: route_id, breack: content[0][2], first_point: true, last_point: false)
      distance = content[0][4].to_i
      content.shift
      content.each do |cont|
        if Point.where(name: cont[0]).blank?
          point = Point.create(name: cont[0])
        else
          point = Point.where(name: cont[0]).first
        end
        Shedule.create(point_id: point.id, route_id: route_id, breack: cont[2], first_point: false, last_point: false)
        if Distance.where(point_id: point.id, neighbor_id: neighbor.id).blank?
          Distance.create(point_id: point.id, neighbor_id: neighbor.id, distance: (cont[4].to_i - distance))
        end
        neighbor = point
        distance = cont[4].to_i
      end
        Shedule.last.update_attributes(last_point: true)
    end

    def clean_old_shedules(route_id)
      Shedule.where(route_id: route_id).each do |shedule|
        shedule.delete
      end
    end

    def clean_old_nodes
      Node.all.each do |node|
        node.delete
      end
    end

    def clean_old_possible_ways
      PossibleWay.all.each do |node|
        node.delete
      end
    end

    def nodes_array
      points_array    = []
      neighbors_array = []
      array_point     = []
      array_neighbor  = []
      Distance.pluck(:point_id, :neighbor_id).each do |distance|
        if Distance.where(point_id: distance[1], neighbor_id: distance[0]).first.blank?
          points_array.push(distance[0]) if array_point.include?(distance[0])
          neighbors_array.push(distance[1]) if array_neighbor.include?(distance[1])
          array_point.push(distance[0])
          array_neighbor.push(distance[1])
        end
      end
      (points_array | neighbors_array).sort
    end

    def choose_nodes
      clean_old_nodes
      nodes_array.each do |node|
        neighbor_nodes_array = nodes_array
        neighbor_nodes_array.delete(node)
        neighbor_array = []
        neighbor_nodes_array.each do |neighbor_node|
          if Shedule.where(point_id: node).pluck(:route_id) & Shedule.where(point_id: neighbor_node).pluck(:route_id) != []
            neighbor_array.push(neighbor_node)
          end
        end
        Node.create(point_id: node, naighbors_array: neighbor_array.uniq.sort)
      end
    end

    def possible_ways
      clean_old_possible_ways
      Node.all.each do |node|
        goals = Node.all.to_a
        @start = node.point_id
        goals.delete(node)
        goals.each do |goal|
          tracks(@start, node.point_id, goal.point_id)
        end
      end
    end

    def graph(start, start_point, finish_point, track_init)
      current_point = Node.where(point_id: start_point).first
      neighbors = string_to_array(current_point.naighbors_array)
      if neighbors.include?(finish_point) && start_point == @start
        PossibleWay.create(point_id: @start, target_point: finish_point, track_array: [start_point, finish_point])
      end
      neighbors.each do |neighbor|
        track = []
        track += track_init
        unless track.include?(neighbor)
          track << neighbor
          if neighbor == finish_point && start_point != @start
            PossibleWay.create(point_id: @start, target_point: finish_point, track_array: track)
          else
            graph(@start, neighbor, finish_point, track)
          end
        end
      end
    end

    def tracks(start, start_point, finish_point)
      graph(start, start_point, finish_point, [start_point])
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
