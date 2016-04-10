module RoutesMacros
	def fill_routes_db_data
		admin = create(:admin)
		visit new_user_session_path
		fill_in 'Email', with: admin.email
		fill_in 'Password', with: admin.password
		click_button 'Log in'
		create_route('./spec/support/files/1_Uzgorod_Kiev.csv')
		create_route('./spec/support/files/2_Kovel_Izmail.csv')
		create_route('./spec/support/files/3_Kishinev_Krasnoarmeisk.csv')
		create_route('./spec/support/files/4_Belgorod_Dn_Kiev.csv')
		create_route('./spec/support/files/5_Melitopol_Kiev.csv')
		create_route('./spec/support/files/6_Sinelnikovo_Belgorod.csv')
		create_route('./spec/support/files/7_Kiev_Kupyansk.csv')
	end

	def create_route(route_csv_file_path)
		route = create(:route)
		visit edit_route_path(route)
		attach_file('route_upload_route_file', File.absolute_path(route_csv_file_path))		
		click_button 'Create Route upload'
	end
end