require 'rails_helper'
require 'carrierwave/test/matchers'

include CarrierWave::Test::Matchers

feature 'Routes manager' do
	scenario 'adds a new route' do
		fill_routes_db_data
		expect(Route.all.count).to eq 7
		expect(Point.all.count).to eq 43
		expect(Node.all.count).to eq 5
		expect(Distance.all.count).to eq 45
		expect(Shedule.all.count).to eq 52
		expect(PossibleWay.all.count).to eq 96
	end
end
