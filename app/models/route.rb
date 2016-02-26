class Route < ActiveRecord::Base
  has_one :route_upload
  has_many :shedules
end
