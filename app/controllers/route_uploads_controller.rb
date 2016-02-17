require 'carrierwave/orm/activerecord'

  class RouteUploadsController < ::ApplicationController

    require 'csv'

    def create
      @route_upload = RouteUpload.create(route_update_params)
      file = @route_upload.route_file
      content = CSV.parse(File.read("#{Rails.root}/public#{file.url}"))
      file_mapper(content, params[:route_upload][:route_id])
      choose_nodes
      redirect_to routes_path
    end

    def file_mapper(content, route_id)
      clean_old_shedules(route_id)
      if Point.where(name: content[0][0]).blank?
        neighbor = Point.create(name: content[0][0])
      else
        neighbor = Point.where(name: content[0][0]).first
      end
      Shedule.create(point_id: neighbor.id, route_id: route_id, breack: content[0][2], first_point: true, last_point: false)
      content.shift
      distance = content[0][4].to_i
      content.each do |cont|
        if Point.where(name: cont[0]).blank?
          point = Point.create(name: cont[0])
        else
          point = Point.where(name: cont[0]).first
        end
        Shedule.create(point_id: point.id, route_id: route_id, breack: cont[2], first_point: false, last_point: false) #исправить на break
        if Distance.where(point_id: point.id, neighbor_id: neighbor.id).blank?
          Distance.create(point_id: point.id, neighbor_id: neighbor.id, distance: (cont[4].to_i - distance))
        end
        neighbor = point
        distance = cont[4].to_i
      end
        Shedule.last.update_attributes(last_point: true)
    end

    def clean_old_shedules(route_id)
      Shedule.where(id: route_id).each do |shedule|
        shedule.delete
      end
    end

    def clean_old_nodes
      Node.all.each do |node|
        node.delete
      end
    end

    def nodes_array
      points_array    = []
      neighbors_array = []
      array_point     = []
      array_neighbor  = []
      Distance.pluck(:point_id, :neighbor_id).each do |distance|
        points_array.push(distance[0]) if array_point.include?(distance[0])
        neighbors_array.push(distance[1]) if array_neighbor.include?(distance[1])
        array_point.push(distance[0])
        array_neighbor.push(distance[1])
      end
      (points_array | neighbors_array).sort
    end

    def choose_nodes
      clean_old_nodes
      nodes_array.each do |node|
        neighbor_array =  Distance.where(point_id: node).pluck(:neighbor_id) + Distance.where(neighbor_id: node).pluck(:point_id)
        Node.create(point_id: node, naighbors_array: neighbor_array.uniq.sort)
      end
    end

    protected

    def route_update_params
      params.require(:route_upload).permit(:route_id, :route_file)
    end
  end
