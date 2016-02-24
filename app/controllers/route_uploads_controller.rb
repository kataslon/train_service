require 'carrierwave/orm/activerecord'

  class RouteUploadsController < ::ApplicationController

    require 'csv'

    def create
      @route_upload = RouteUpload.create(route_upload_params)
      redirect_to routes_path
    end

    protected

    def route_upload_params
      params.require(:route_upload).permit(:route_id, :route_file)
    end
end
