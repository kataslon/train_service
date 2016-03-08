class PointsController < ::ApplicationController

  def show
    @point = Point.find(params[:id])
    @train_shedule = @point.train_shedule
  end

  def new_point_shedule
    @point = Point.new
  end

end
