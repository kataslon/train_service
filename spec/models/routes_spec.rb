require 'rails_helper'

describe Route do
	
	before :each do
		@route = Route.new(
			name: 'route_1',
			speed: 90,
			places_count: 210,
		  left_daparture: '15:30',
		  right_daparture: '12:45',
		  tariff: 5.6)
	end

	describe "is invalid without" do
		it "a name" do
			@route.update_attributes(name: nil)
			@route.valid?
			expect(@route.errors[:name]).to include("can't be blank")
		end

		it "a speed" do
			@route.update_attributes(speed: nil)
			@route.valid?
			expect(@route.errors[:speed]).to include("can't be blank")
		end

		it "is invalid with speed less than zerro" do
			@route.update_attributes(speed: -1)
			@route.valid?
			expect(@route.errors[:speed]).to include("must be greater than 0")
		end

		it "a places_count" do
			@route.update_attributes(places_count: nil)
			@route.valid?
			expect(@route.errors[:places_count]).to include("can't be blank")
		end

		it "is invalid with places_count less than zerro" do
			@route.update_attributes(places_count: -1)
			@route.valid?
			expect(@route.errors[:places_count]).to include("must be greater than 0")
		end

		it "a left_daparture" do
			@route.update_attributes(left_daparture: nil)
			@route.valid?
			expect(@route.errors[:left_daparture]).to include("can't be blank")
		end

		it "a right_daparture" do
			@route.update_attributes(right_daparture: nil)
			@route.valid?
			expect(@route.errors[:right_daparture]).to include("can't be blank")
		end

		it "a tariff" do
			@route.update_attributes(tariff: nil)
			@route.valid?
			expect(@route.errors[:tariff]).to include("can't be blank")
		end

		it "is invalid with tariff less than zerro" do
			@route.update_attributes(tariff: -1)
			@route.valid?
			expect(@route.errors[:tariff]).to include("must be greater than 0")
		end

		it "is valid with correct data" do
			expect(@route).to be_valid
		end
	end
end