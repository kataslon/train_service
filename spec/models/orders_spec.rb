require 'rails_helper'

describe Order do
	
	before :each do
		@order = Order.new(
			user_id: 1,
			start_point: 2,
			goal_point: 9,
		  date: '28.03.2016',
		  nodes_array: [3, 6, 12],
		  track_array: [2, 3, 4, 5, 6, 7, 8, 9])
	end

	describe "is invalid without" do
		it "a user_id" do
			@order.update_attributes(user_id: nil)
			@order.valid?
			expect(@order.errors[:user_id]).to include("can't be blank")
		end

		it "a start_point" do
			@order.update_attributes(start_point: nil)
			@order.valid?
			expect(@order.errors[:start_point]).to include("can't be blank")
		end

		it "a goal_point" do
			@order.update_attributes(goal_point: nil)
			@order.valid?
			expect(@order.errors[:goal_point]).to include("can't be blank")
		end

		it "a date" do
			@order.update_attributes(date: nil)
			@order.valid?
			expect(@order.errors[:date]).to include("can't be blank")
		end

		it "a nodes_array" do
			@order.update_attributes(nodes_array: nil)
			@order.valid?
			expect(@order.errors[:nodes_array]).to include("can't be blank")
		end

		it "a track_array" do
			@order.update_attributes(track_array: nil)
			@order.valid?
			expect(@order.errors[:track_array]).to include("can't be blank")
		end
	end

	it "is valid with correct data" do
		expect(@order).to be_valid
	end
end