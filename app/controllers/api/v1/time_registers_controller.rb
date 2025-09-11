class Api::V1::TimeRegistersController < ApplicationController
  before_action :set_time_register, only: %i[show update destroy]

  def index
    time_registers = TimeRegister.includes(:user).all

    if params[:page]
      @pagy, time_registers = pagy(time_registers, items: 15, page: params[:page])
    end

    render json: time_registers,
           each_serializer: Api::V1::TimeRegisters::Index::TimeRegisterSerializer,
           status: :ok
  end

  def show
    render json: @time_register,
           serializer: Api::V1::TimeRegisters::Show::TimeRegisterSerializer,
           status: :ok
  end

  def create
    time_register = TimeRegister.create!(time_register_params)

    render json: time_register,
           serializer: Api::V1::TimeRegisters::Create::TimeRegisterSerializer,
           status: :created
  end

  def update
    @time_register.update!(time_register_params)
    
    head :no_content
  end

  def destroy
    @time_register.destroy!

    head :no_content
  end

  private

  def set_time_register
    @time_register = TimeRegister.find(params[:id])
  end

  def time_register_params
    params.require(:time_register).permit(:user_id, :clock_in, :clock_out)
  end
end
