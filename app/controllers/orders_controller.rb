class OrdersController < ::ApplicationController

  # def new
  #   @order = Order.new
  #   @route = RouteReference.new(reference_params)
  # end

  def create
    # @route_references = RouteReference.new(reference_params).prepare_routes
    # @route = @route_references[(params[:id])]
    order = Order.create(order_params)
    redirect_to edit_order_path(order)
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order.update_params()
    @order.reserve_tickets()
  end

protected

  def order_params
    params.require(:order).permit(:user_id, :start_point, :goal_point, :date, :nodes_array, :track_array)
  end

end
