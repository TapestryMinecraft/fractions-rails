json.id @electorate.id
json.name @electorate.name

# json.characters @electorate.characters do |character|
#   json.extract! character, :id, :name
# end
json.fraction do
  json.id @electorate.fraction.id
  json.name @electorate.fraction.name
end