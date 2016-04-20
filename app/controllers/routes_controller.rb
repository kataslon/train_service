class RoutesController < ::ApplicationController
  before_action :authenticate_user!
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  def index
    @routes = Route.all
  end

  def new
    @route = Route.new
  end

  def create
    @route = Route.new(route_params)
    respond_to do |format|
      if @route.save
        format.html { redirect_to routes_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    @route.update(route_params)
    respond_to do |format|
      if @route.save
        format.html { redirect_to routes_path }
      else
        format.html { render :edit }
      end
    end
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
