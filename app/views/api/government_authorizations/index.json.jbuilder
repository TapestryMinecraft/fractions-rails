# TODO this is not being used

json.array! @government_authorizations.map do |authorization|
  json.extract! authorization, :authorization_type
  json.authorizee do
    json.extract! authorization.authorizee, :id, :name
    json.type authorization.authorizee_type
  end
  json.authorizer do
    json.extract! authorization.authorizer, :id, :name
    json.type authorization.authorizer_type
  end
end
