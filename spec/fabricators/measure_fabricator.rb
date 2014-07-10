Fabricator(:measure) do 
  name { Faker::Name.name }
  description { Faker::Lorem.sentence }
  min_value { 0 }
  max_value { rand(20) }
end