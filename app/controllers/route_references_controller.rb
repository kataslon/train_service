class RouteReferencesController < ::ApplicationController

  def new
    @route_references = RouteReference.new(params)
  end

  def create
    @route_references = RouteReference.new(reference_params)
  end

  def index
    redirect_to new_route_reference_url if params[:route_reference][:start_point] == params[:route_reference][:goal_point]
    @routes = RouteReference.new(reference_params)
    @route_references = @routes.prepare_routes
    @order = Order.new
  end

  protected

  def reference_params
    params.require(:route_reference).permit(:start_point, :goal_point)
  end

end
