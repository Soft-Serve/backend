require 'rails_helper'

RSpec.describe RestaurantsController do
  let!(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:tint) { 400 }
  let(:params) do
    {
      name: 'Akira Back',
      colour: 'red',
      tint: tint,
      slug: 'akiraback'
    }
  end

  def json
    JSON.parse(response.body)
  end

  describe 'GET #show' do
    let(:id) { restaurant.id }

    before { get :show, params: { id: id }  }

    context 'when id is valid' do
      it do
        expect(response).to have_http_status(:ok)
        expect(json['id']).to eq(id)
      end
    end

    context 'when id is invalid' do
      let(:id) { 8989 }
      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('errors')
      end
    end
  end

  describe 'POST #create' do
    before { post :create, params: params }

    context 'when params are valid' do
      it do
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('Akira Back')
      end
    end
  end

  describe 'PATCH #update' do
    let(:update_params) { {} }
    before { patch :update, params: update_params.merge(id: restaurant.id) }

    context 'when params are valid' do
      let(:update_params) { { name: 'O&B' } }
      it do
        expect(json['name']).to eq('O&B')
      end
    end

    context 'when params are invalid' do
      let(:update_params) { { currency: 'dsgwee' } }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:destroy_params) { { id: restaurant.id } }

    it do
      expect { patch :destroy, params: destroy_params }.to change { Restaurant.count }.by(-1)
    end
  end
end
