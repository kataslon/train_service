require 'rails_helper'

describe Ticket do
	before :each do
		@ticket = Ticket.new(
			order_id: 1,
	    route_id: 2,
	    start_point: 3,
	    finish_point: 7,
	    route_round_date: '28.03.2016')
	end

	describe "is invalid without" do
		it "a order_id" do
			@ticket.update_attributes(order_id: nil)
			@ticket.valid?
			expect(@ticket.errors[:order_id]).to include("can't be blank")
		end

		it "a route_id" do
			@ticket.update_attributes(route_id: nil)
			@ticket.valid?
			expect(@ticket.errors[:route_id]).to include("can't be blank")
		end

		it "a start_point" do
			@ticket.update_attributes(start_point: nil)
			@ticket.valid?
			expect(@ticket.errors[:start_point]).to include("can't be blank")
		end

		it "a finish_point" do
			@ticket.update_attributes(finish_point: nil)
			@ticket.valid?
			expect(@ticket.errors[:finish_point]).to include("can't be blank")
		end

		it "a route_round_date" do
			@ticket.update_attributes(route_round_date: nil)
			@ticket.valid?
			expect(@ticket.errors[:route_round_date]).to include("can't be blank")
		end
	end

	it "is valid with correct data" do
		expect(@ticket).to be_valid
	end	
end