class PointReference

  include ActiveModel::Model

  attr_accessor :point

  def initialize(params)
    self.point = params[:point].to_i
  end

  def train_shedule
    point_shedule = {}
    Shedule.where(point_id: self.point).pluck(:route_id).each do |route_id|
      route_data_left = []
      route_data_right = []
      first_point = Shedule.where(route_id: route_id, first_point: true).first.point_id
      last_point = Shedule.where(route_id: route_id, last_point: true).first.point_id
      route_data_left.push(Point.find(first_point).name)
      route_data_left.push(Point.find(last_point).name)
      route_data_right.push(Point.find(last_point).name)
      route_data_right.push(Point.find(first_point).name)
      if self.point == first_point
        route_data_left.push(nil)
        route_data_left.push(nil)
        route_data_left.push(Route.find(route_id).travel_time_left(self.point))
        route_data_right.push(Route.find(route_id).right_daparture)
        route_data_right.push(nil)
        route_data_right.push(nil)
        point_shedule[route_data_left[4]] = route_data_left
        point_shedule[route_data_right[2]] = route_data_right
      elsif self.point == last_point
        route_data_left.push(Route.find(route_id).travel_time_left(self.point))
        route_data_left.push(nil)
        route_data_left.push(nil)
        route_data_right.push(nil)
        route_data_right.push(nil)
        route_data_right.push(Route.find(route_id).right_daparture)
        point_shedule[route_data_left[2]] = route_data_left
        point_shedule[route_data_right[4]] = route_data_right
      else
        route_data_left.push(Route.find(route_id).travel_time_left(self.point))
        route_data_right.push(Route.find(route_id).travel_time_right(self.point))
        breack = Shedule.where(route_id: route_id, point_id: self.point).first.breack
        route_data_left.push(breack)
        route_data_right.push(breack)
        route_data_left.push(Route.find(route_id).travel_time_left(self.point) + breack)
        route_data_right.push(Route.find(route_id).travel_time_right(self.point) + breack)
        point_shedule[route_data_left[2]] = route_data_left
        point_shedule[route_data_right[2]] = route_data_right
      end
    end
    point_shedule.sort
  end

end
