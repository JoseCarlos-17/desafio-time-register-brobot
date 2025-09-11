class Api::V1::Users::Show::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
