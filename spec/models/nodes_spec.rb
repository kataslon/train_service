require 'rails_helper'

describe Node do
	
	it "is invalid without point_id" do
		node = Node.new(point_id: nil)
		node.valid?
		expect(node.errors[:point_id]).to include("can't be blank")
	end

	it "is invalid without neighbors_array" do
		node = Node.new(naighbors_array: nil)
		node.valid?
		expect(node.errors[:naighbors_array]).to include("can't be blank")
	end

	it "is valid with correct data" do
		node = Node.new(point_id: 3, naighbors_array: [6, 12])
		expect(node).to be_valid
	end

end