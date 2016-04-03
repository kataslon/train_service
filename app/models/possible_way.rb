class PossibleWay < ActiveRecord::Base

	validates :point_id,     presence: true
	validates :target_point, presence: true
	validates :track_array,  presence: true

end
