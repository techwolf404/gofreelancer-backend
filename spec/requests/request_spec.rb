require 'rails_helper'

RSpec.describe 'Controllers', type: :request do
  describe 'Specializations' do
    describe 'get#index' do
      before do
        FactoryBot.create_list(:specialization, 10)
        get '/api/v1/specializations'
      end

      it 'response status success' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns all specializations' do
        expect(json.size).to eq(10)
      end
    end
  end
  describe 'Freelancers' do
    describe 'get#index' do
      before do
        FactoryBot.create_list(:freelancer, 10)
        get '/api/v1/freelancers'
      end

      it 'response status success' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns all freelancers' do
        expect(json.size).to eq(10)
      end
    end
    describe 'get#show' do
      before do
        @freelancer = FactoryBot.create(:freelancer)
        get "/api/v1/freelancers/#{@freelancer.id}"
      end

      it 'response status success' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns specific freelancer' do
        expect(json['id']).to eq(@freelancer.id)
        expect(json['name']).to eq(@freelancer.name)
        expect(json['details']).to eq(@freelancer.details)
        expect(json['photo']).to eq(@freelancer.photo)
      end
    end
  end
  describe 'Reservations' do
    describe 'get#all' do
      before(:all) do
        @me = FactoryBot.create(:user)
        @my_freelancer = FactoryBot.create(:freelancer)
        10.times do
          FactoryBot.create(:reservation, user: @me, freelancer: @my_freelancer)
        end
        get '/api/v1reservations', params: nil, headers: credentials_header_for(@me)
      end
      it 'response status success' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns specific user\'s reservations' do
        expect(json.size).to eq(10)
      end
    end
  end
end
