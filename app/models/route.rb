class Route < ActiveRecord::Base
  has_many :route_uploads

  mount_uploader :route_file, RouteFileUploader

end
