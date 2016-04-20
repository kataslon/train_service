require 'rails_helper'

describe Point do

	it "does not allow duplicate name for two enother points" do
		Point.create(name: 'first')
		point = Point.new(name: 'first')
		point.valid?
		expect(point.errors[:name]).to include("has already been taken")
	end

end
