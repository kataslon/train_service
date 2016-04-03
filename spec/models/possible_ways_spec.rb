require 'rails_helper'

describe PossibleWay do
	before :each do
		@possible_way = PossibleWay.new(
			point_id: 1,
			target_point: 15,
			track_array: [1, 2, 3, 9, 10, 11, 12, 16, 15])
	end

	describe "is invalid without" do
		it "a point_id" do
			@possible_way.update_attributes(point_id: nil)
			@possible_way.valid?
			expect(@possible_way.errors[:point_id]).to include("can't be blank")
		end

		it "a target_point" do
				@possible_way.update_attributes(target_point: nil)
				@possible_way.valid?
				expect(@possible_way.errors[:target_point]).to include("can't be blank")
		end

		it "a track_array" do
				@possible_way.update_attributes(track_array: nil)
				@possible_way.valid?
				expect(@possible_way.errors[:track_array]).to include("can't be blank")
		end

		it "is valid with correct data" do
			expect(@possible_way).to be_valid
		end		
	end
end