Fabricator(:business) do
	name { Faker::Name.name }
	address { Faker::Address.street_address }
	food_type { Faker::Food.dish }
end