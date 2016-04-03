require 'rails_helper'

describe Shedule do
	
	before :each do
		@shedule = Shedule.new(
			point_id: 1,
			route_id: 7,
			breack: 210)
	end

	describe "is invalid without" do
		it "a point_id" do
			@shedule.update_attributes(point_id: nil)
			@shedule.valid?
			expect(@shedule.errors[:point_id]).to include("can't be blank")
		end

		it "a route_id" do
			@shedule.update_attributes(route_id: nil)
			@shedule.valid?
			expect(@shedule.errors[:route_id]).to include("can't be blank")
		end
	end

	it "is valid with correct data" do
		expect(@shedule).to be_valid
	end
end