class RoutesController < ::ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  def show

  end

  def index
    @routes = Route.all
  end

  def new
    @route = Route.new
  end

  def create
    @route = Route.create(route_params)
    redirect_to routes_path
  end

  def edit
    @route = Route.find_by(id: params[:id])
  end

  def update

  end

  def destroy
    @route.destroy
    redirect_to routes_path
  end

  def upload
    @route_upload = RouteUpload.create(route_update_params)
    file = @route_upload.route_file
    content = CSV.parse(File.read("#{Rails.root}/public#{file.url}"))
    file_mapper(content, params[])
  end

  protected

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name,
                                  :speed,
                                  :places_cout,
                                  :daparture,
                                  :tariff)
  end

end
