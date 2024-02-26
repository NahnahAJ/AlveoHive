class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at, :firstname, :lastname, :jti

  attributes :created_at do |object|
    object.created_at.strftime("%m, %d, %Y")
  end
end