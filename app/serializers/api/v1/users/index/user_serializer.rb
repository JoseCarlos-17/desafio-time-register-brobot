class Api::V1::Users::Index::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
