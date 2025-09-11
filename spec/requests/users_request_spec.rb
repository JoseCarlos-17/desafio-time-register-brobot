require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET#index" do
    context 'when have a user list' do
      let!(:users) { create_list(:user, 2) }

      before do
        get '/api/v1/users'
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the user attributes from the first element' do
        expect(json_body[0]).to include(:name, :email)
      end
    end

    context 'when the list is paginated' do
      let!(:users) { create_list(:user, 30) }

      before do
        get '/api/v1/users', params: { page: 1 }
      end

      it 'must return 15 users' do
        expect(json_body.count).to eq(20)
      end
    end
  end

  describe "POST#create" do
    context 'when the user is registered' do
      let(:user_params) { attributes_for(:user, name: "John doe",
        email: "johndoe@gmail.com") }

      before do
        post '/api/v1/users', params: { user: user_params }
      end

      it 'must return status 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'must return user attributes' do
        expect(json_body).to include(:name, :email)
      end
    end

    context 'when the user send wrong attributes' do
      let(:invalid_params) { attributes_for(:user, name: nil, email: nil) }

      before do
        post '/api/v1/users', params: { user: invalid_params }
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
    context 'when a user see your details' do
      let!(:user) { create(:user) }

      before do
        get "/api/v1/users/#{user.id}"
      end

      it 'must return 200 ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return user attributes' do
        expect(json_body).to include(:name, :email)
      end
    end
  end

  describe 'PUT#update' do
    context 'when a user see your details' do
      let!(:user) { create(:user) }
      let(:user_params) { attributes_for(:user, name: "John doe",
        email: "johndoe@gmail.com") }

      before do
        put "/api/v1/users/#{user.id}",
        params: { user: user_params }
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'when a user wants to delete your own account' do
      let!(:user) { create(:user) }

      before do
        delete "/api/v1/users/#{user.id}"
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'GET#time_registers' do
    context 'when the user have time registers' do
      let!(:user) { create(:user) }
      let!(:time_registers_list) { create_list(:time_register, 2, user: user) }

      before do
        get "/api/v1/users/#{user.id}/time_registers"
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the user time register attributes from the first element' do
        expect(json_body[0]).to include(:id, :clock_in, :clock_out, :user_id)
      end
    end
  end
end
