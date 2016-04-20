FactoryGirl.define do
	factory :user do
		email {Faker::Internet.email}
		password 'long_secret'
		password_confirmation 'long_secret'

		factory :admin do
			admin true
		end
	end
end