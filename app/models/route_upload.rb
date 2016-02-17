class RouteUpload < ActiveRecord::Base
  belongs_to :route

  mount_uploader :route_file, RouteFileUploader

  def method_name

  end
end
