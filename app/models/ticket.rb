class Ticket < ActiveRecord::Base
  belongs_to :order

  def cost

  end

  def method_name

  end

  def travel_time

  end


  def total_distance(start_point, finish_point)
    distance += Distance.where(neighbor_id: start_point, point_id: finish_point)
  end
end
