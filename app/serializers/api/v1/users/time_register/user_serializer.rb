class Api::V1::Users::TimeRegister::UserSerializer < ActiveModel::Serializer
  attributes :id, :clock_in, :clock_out, :user_id
end
