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
  end

  def update
    @route.update(route_params)
    redirect_to routes_path
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
                                  :places_count,
                                  :left_daparture,
                                  :right_daparture,
                                  :tariff)
  end

end
