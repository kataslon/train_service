require 'rails_helper'
require 'carrierwave/test/matchers'

include CarrierWave::Test::Matchers

feature 'Routes manager' do
	scenario 'adds a new route' do

		visit routes_path
		click_link 'New'
		fill_in 'Name', with: 'route_1'
		fill_in 'Speed', with: '90'
		fill_in 'Places count', with: '120'
		fill_in 'Left daparture', with: '12:00'
		fill_in 'Right daparture', with: '18:00'
		fill_in 'Tariff', with: '5'
		click_button 'Create Route'
		route = Route.last

		expect(page).to have_content 'route_1'

		visit edit_route_path(route)
		attach_file('route_upload_route_file', File.absolute_path('./spec/support/files/1_Uzgorod_Kiev.csv'))		
		click_button 'Create Route upload'

		visit routes_path
		click_link 'New'
		fill_in 'Name', with: 'route_2'
		fill_in 'Speed', with: '90'
		fill_in 'Places count', with: '120'
		fill_in 'Left daparture', with: '12:00'
		fill_in 'Right daparture', with: '18:00'
		fill_in 'Tariff', with: '5'
		click_button 'Create Route'
		route = Route.last

		visit edit_route_path(route)
		attach_file('route_upload_route_file', File.absolute_path('./spec/support/files/2_Kovel_Izmail.csv'))		
		click_button 'Create Route upload'
		
		visit routes_path
		click_link 'New'
		fill_in 'Name', with: 'route_4'
		fill_in 'Speed', with: '90'
		fill_in 'Places count', with: '120'
		fill_in 'Left daparture', with: '12:00'
		fill_in 'Right daparture', with: '18:00'
		fill_in 'Tariff', with: '5'
		click_button 'Create Route'
		route = Route.last

		visit edit_route_path(route)
		attach_file('route_upload_route_file', File.absolute_path('./spec/support/files/4_Belgorod_Dn_Kiev.csv'))		
		click_button 'Create Route upload'

		expect(Route.all.count).to eq 3
		expect(Point.all.count).to eq 19
		expect(Node.all.count).to eq 3
		expect(Distance.all.count).to eq 19
		expect(Shedule.all.count).to eq 22
		expect(PossibleWay.all.count).to eq 12

	end
end