class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :time_registers]

  def index
    users = User.all

    if params[:page]
      @pagy, users = pagy(users, items: 15, page: params[:page])
    end

    render json: users,
           each_serializer: Api::V1::Users::Index::UserSerializer,
           status: :ok
  end

  def show
    render json: @user, serializer: Api::V1::Users::Show::UserSerializer, status: :ok
  end

  def create
    user = User.create!(user_params)

    render json: user,
           serializer: Api::V1::Users::Create::UserSerializer,
           status: :created
  end

  def update
    @user.update!(user_params)

    head :no_content
  end

  def destroy
    @user.destroy!

    head :no_content
  end

  def time_registers
    render json: @user.time_registers,
           each_serializer: Api::V1::Users::TimeRegister::UserSerializer,
           status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
