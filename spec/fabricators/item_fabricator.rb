Fabricator(:item) do 
  name { Faker::Name.name }
  description { Faker::Lorem.sentence }
end