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
    @route = RouteUpload.new(route_params)
    redirect_to routes_path
  end

  def edit
  end

  def update
  end

  def destroy
    @route.destroy
    redirect_to routes_path
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
