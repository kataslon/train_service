require 'carrierwave/orm/activerecord'

  class RouteUploadsController < ::ApplicationController

    require 'csv'

    def create
      @route_upload = RouteUpload.create(route_update_params)
      file = @route_upload.route_file
      content = CSV.parse(File.read("#{Rails.root}/public#{file.url}"))
      file_mapper(content, params[:route_upload][:route_id])
      redirect_to routes_path
    end

    def file_mapper(content, route_id)
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
        Distance.create(point_id: point.id, neighbor_id: neighbor.id, distance: (cont[4].to_i - distance))
        neighbor = point
        distance = cont[4].to_i
      end
        Shedule.last.update_attributes(last_point: true)
    end


    protected

    def route_update_params
      params.require(:route_upload).permit(:route_id, :route_file)
    end
  end
