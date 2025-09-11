require 'rails_helper'

RSpec.describe "Api::V1::TimeRegisters", type: :request do
   describe "GET#index" do
    context 'when have a time_register list' do
      let!(:user) { create(:user) }
      let!(:time_registers) { create_list(:time_register, 2, user: user) }

      before do
        get '/api/v1/time_registers'
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the user attributes from the first element' do
        expect(json_body[0]).to include(:id, :clock_in, :clock_out, :user_id)
      end
    end

    context 'when the list is paginated' do
      let!(:user) { create(:user) }
      let!(:time_registers) { create_list(:time_register, 30, user: user) }

      before do
        get '/api/v1/time_registers', params: { page: 1 }
      end

      it 'must return 20 time registers' do
        expect(json_body.count).to eq(20)
      end
    end
  end

  describe "POST#create" do
    context 'when the time register is created' do
      let!(:user) { create(:user) }
      let(:time_register_params) { attributes_for(:time_register,
        clock_in: "2025-09-09 10:00:00", clock_out: "2025-09-09 10:30:00",
        user_id: user.id) }

      before do
        post '/api/v1/time_registers',
        params: { time_register: time_register_params }
      end

      it 'must return status 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'must return user attributes' do
        expect(json_body).to include(:id, :clock_in, :clock_out, :user_id)
      end
    end

    context 'when send wrong attributes' do
      let!(:user) { create(:user) }
      let(:time_register_invalid_params) { attributes_for(:time_register,
        clock_in: nil, clock_out: nil, user_id: user.id) }

      before do
        post '/api/v1/time_registers',
        params: { time_register: time_register_invalid_params }
      end

      it 'must return status 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return errors message' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  describe "GET#show" do
    context 'when i see a time register details' do
      let!(:user) { create(:user) }
      let!(:time_register) { create(:time_register, user: user) }

      before do
        get "/api/v1/time_registers/#{time_register.id}"
      end

      it 'must return 200 ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return user attributes' do
        expect(json_body).to include(:id, :clock_in, :clock_out, :user_id)
      end
    end
  end

  describe 'PUT#update' do
    context 'when a time register is updated' do
      let!(:user) { create(:user) }
      let!(:time_register) { create(:time_register, user: user) }
      let(:time_register_params) { attributes_for(:time_register,
        clock_in: "2025-09-09 10:00:00", clock_out: "2025-09-09 10:30:00",
        user_id: user.id) }

      before do
        put "/api/v1/time_registers/#{time_register.id}",
        params: { time_register: time_register_params }
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'when a time register is deleted' do
      let!(:user) { create(:user) }
      let!(:time_register) { create(:time_register, user: user) }

      before do
        delete "/api/v1/time_registers/#{time_register.id}"
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
