class Api::V1::Users::Create::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
