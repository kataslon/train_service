class Point < ActiveRecord::Base
  has_many :shedules

  validates :name, uniqueness: true

end
