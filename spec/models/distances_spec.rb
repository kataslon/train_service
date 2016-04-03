require 'rails_helper'

describe Distance do
	
	it 'is invalid without a distance' do
		distance = Distance.new(distance: nil)
		distance.valid?
		expect(distance.errors[:distance]).to include("can't be blank")
	end

	it "dosn't allow to create distance with value less than zerro" do
		distance = Distance.new(distance: -1)
		distance.valid?
		expect(distance.errors[:distance]).to include("must be greater than 0")
	end

	it "is valid with correct data" do
		distance = Distance.new(distance: 75)
		expect(distance).to be_valid
	end

end