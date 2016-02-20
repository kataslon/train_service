class Route < ActiveRecord::Base
  has_many :route_uploads
  has_many :shedules

  mount_uploader :route_file, RouteFileUploader

end
