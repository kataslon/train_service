class PointsController < ::ApplicationController

  before_action :set_point

  def show
    @train_shedule = @point.train_shedule
  end

  protected

  def set_point
    @point = Point.find(params[:id])
  end

end
