class Shedule < ActiveRecord::Base
  belongs_to :route 
  belongs_to :point

  validates :point_id, presence: true
  validates :route_id, presence: true
end
