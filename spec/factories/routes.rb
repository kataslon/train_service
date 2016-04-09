FactoryGirl.define do
	factory :route do
		name { Faker::Lorem.word }
		speed { Faker::Number.number(2)}
		places_count { Faker::Number.number(2)}
		left_daparture { Faker::Time.between(DateTime.now - 1, DateTime.now) }
		right_daparture { Faker::Time.between(DateTime.now - 1, DateTime.now) }
		tariff { Faker::Number.decimal(2) }

		factory :invalid_route do
			name nil
		end
	end
end