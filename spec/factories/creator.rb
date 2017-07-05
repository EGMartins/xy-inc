FactoryGirl.define do
	factory :creator do |f|
		f.name { Faker::Name.name }
		f.info { Faker::ChuckNorris.fact }
	end
end
