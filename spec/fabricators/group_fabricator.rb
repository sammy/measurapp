Fabricator(:group) do 
  name          { Faker::Commerce.department }
  description   { Faker::Company.bs }
end