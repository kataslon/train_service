class Node < ActiveRecord::Base

	validates :point_id, presence: true
	validates :naighbors_array, presence: true

end
