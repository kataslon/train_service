class Ticket < ActiveRecord::Base
  belongs_to :order

  validates :order_id, presence: true
	validates :start_point, presence: true
	validates :route_id, presence: true
	validates :finish_point, presence: true
	validates :route_round_date, presence: true

  def total_distance(start_point, finish_point)
    distance += Distance.where(neighbor_id: start_point, point_id: finish_point)
  end
end
