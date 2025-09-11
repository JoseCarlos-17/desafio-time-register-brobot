class Api::V1::TimeRegisters::Show::TimeRegisterSerializer < ActiveModel::Serializer
  attributes :id, :clock_in, :clock_out, :user_id
end
