class Shedule < ActiveRecord::Base
  belongs_to :route #autodelate
  belongs_to :point
end
