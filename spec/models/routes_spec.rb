require 'rails_helper'

describe Route do
	describe "is invalid without" do
		it "a name" do
			route = build(:route, name: nil)
			route.valid?
			expect(route.errors[:name]).to include("can't be blank")
		end

		it "a speed" do
			route = build(:route, speed: nil)
			route.valid?
			expect(route.errors[:speed]).to include("can't be blank")
		end

		it "is invalid with speed less than zerro" do
			route = build(:route, speed: -1)
			route.valid?
			expect(route.errors[:speed]).to include("must be greater than 0")
		end

		it "a places_count" do
			route = build(:route, places_count: nil)
			route.valid?
			expect(route.errors[:places_count]).to include("can't be blank")
		end

		it "is invalid with places_count less than zerro" do
			route = build(:route, places_count: -1)
			route.valid?
			expect(route.errors[:places_count]).to include("must be greater than 0")
		end

		it "a left_daparture" do
			route = build(:route, left_daparture: nil)
			route.valid?
			expect(route.errors[:left_daparture]).to include("can't be blank")
		end

		it "a right_daparture" do
			route = build(:route, right_daparture: nil)
			route.valid?
			expect(route.errors[:right_daparture]).to include("can't be blank")
		end

		it "a tariff" do
			route = build(:route, tariff: nil)
			route.valid?
			expect(route.errors[:tariff]).to include("can't be blank")
		end

		it "is invalid with tariff less than zerro" do
			route = build(:route, tariff: -1)
			route.valid?
			expect(route.errors[:tariff]).to include("must be greater than 0")
		end

		it "is valid with correct data" do
			expect(build(:route)).to be_valid
		end
	end
end