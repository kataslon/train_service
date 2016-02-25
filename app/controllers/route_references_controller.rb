class RouteReferencesController < ::ApplicationController

  def new
    @route_references = RouteReference.new(params)
  end

  def create
    @route_references = RouteReference.new(reference_params)

  end

  def show
    @route_reference = @references[params(track_id)]
  end

  def index
    @route_references = RouteReference.new(reference_params)
    # @route_references.prepare_routes
    render text: @route_references.prepare_routes.to_s
  end

  protected

  def reference_params
    params.require(:route_reference).permit(:start_point, :goal_point)
  end

end
