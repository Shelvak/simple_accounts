Fabricator(:client) do
    name { Faker::Name.name }
    identifier { Faker::Lorem.sentence }
    card { Faker::Lorem.sentence }
end
