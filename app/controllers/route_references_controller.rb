class RouteReferencesController < ::ApplicationController

  def new
    @route_references = RouteReference.new(params)
  end

  def create
    @route_references = RouteReference.new(reference_params)

  end

  def show
    @route_reference = PossibleWay.find(params[:id])
  end

  def index
    @route = RouteReference.new(reference_params)
    @route_references = RouteReference.new(reference_params).prepare_routes
  end

  protected

  def reference_params
    params.require(:route_reference).permit(:start_point, :goal_point)
  end

end
