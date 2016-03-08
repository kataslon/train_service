class PointReferencesController < ::ApplicationController

  def new
    @point_reference = PointReference.new(params)
  end

  def create
    @point_reference = PointReference.new(point_params)
  end

  def index
    @point_reference = PointReference.new(point_params)
    @point_shedule = @point_reference.train_shedule
  end

  protected

  def point_params
    params.require(:point_reference).permit(:point)
  end

end
