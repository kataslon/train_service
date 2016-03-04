class OrdersController < ::ApplicationController

  def new
    @order = Order.new(order_params)
    @user = current_user
    @total_track = @order.total_track
    @total_route_distance = 0
    @total_track.each do |route_hash|
      route_hash.each do |point|
        hash = point[1]
        @total_distance = hash[:total_distance]
      end
      @total_route_distance += @total_distance
    end
  end

  def create
    order = Order.create(order_params)
    redirect_to edit_order_url(order)
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
