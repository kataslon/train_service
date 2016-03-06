class OrdersController < ::ApplicationController

  def new
    @order = Order.new(order_params)
    @user = current_user
    @total_track = @order.total_track
    @start_point = params[:order][:start_point]
    @goal_point  = params[:order][:goal_point]
    @nodes_array = params[:order][:nodes_array]
    @track_array = params[:order][:track_array]
    @total_route_distance = 0
    @total_track.each do |route_hash|
      route_hash.each do |point|
        hash = point[1]
        @total_distance = hash[:total_distance]
      end
      @total_route_distance += @total_distance
      @order.tickets.build
    end
  end

  def create
    order = Order.create(order_params)
    redirect_to order_url(order)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to new_route_reference_path
  end

protected

  def order_params
    params.require(:order).permit(:user_id, :start_point, :goal_point, :date, :nodes_array, :track_array,
                                  tickets_attributes: [:route_id, :start_point, :finish_point])
  end

end
