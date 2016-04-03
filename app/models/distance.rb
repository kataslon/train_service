class Distance < ActiveRecord::Base
  
  validates :distance, presence: true,
						numericality: { greater_than: 0 }

end
