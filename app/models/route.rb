class Route < ActiveRecord::Base
  has_one :route_upload
  has_many :shedules

  def travel_time_right(point)
    current_point = Shedule.where(route_id: self.id, last_point: true).first.point_id
    travel_time = self.right_daparture
    while current_point != point
      Distance.where(point_id: current_point).pluck(:neighbor_id).each do |id|
        if Shedule.where(route_id: self.id).pluck(:point_id).include?(id)
          distance = Distance.where(point_id: current_point, neighbor_id: id).first.distance
          breack = Shedule.where(point_id: id, route_id: self.id).first.breack
          travel_time += distance.to_f / self.speed.to_f * 3600 + breack
          current_point = id
        end
      end
    end
    travel_time
  end

    def travel_time_left(point)
    current_point = Shedule.where(route_id: self.id, first_point: true).first.point_id
    travel_time = self.left_daparture
    while current_point != point
      Distance.where(neighbor_id: current_point).pluck(:point_id).each do |id|
        if Shedule.where(route_id: self.id).pluck(:point_id).include?(id)
          distance = Distance.where(neighbor_id: current_point, point_id: id).first.distance
          breack = Shedule.where(point_id: id, route_id: self.id).first.breack
          travel_time += distance.to_f / self.speed.to_f * 3600 + breack
          current_point = id
        end
      end
    end
    travel_time
  end

end
