require 'rails_helper'

RSpec.describe MenusController do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:name) { 'Lunch Menu' }
  let(:params) { { name: name, restaurant_id: restaurant.id } }

  def json
    JSON.parse(response.body)
  end

  describe 'GET #show' do
    let(:id) { menu.id }

    before { get :show, params: { id: id, restaurant_id: restaurant.id } }

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
        expect(json['name']).to eq('Lunch Menu')
      end
    end

    context 'when params are invalid' do
      let(:name) { nil }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('errors')
      end
    end
  end

  describe 'PATCH #update' do
    let(:update_params) { {} }
    before { patch :update, params: update_params.merge(id: menu.id, restaurant_id: restaurant.id)  }

    context 'when params are valid' do
      let(:update_params) { { name: 'Brunch!' } }
      it do
        expect(json['name']).to eq('Brunch!')
      end
    end

    context 'when params are invalid' do
      let(:update_params) { { name: nil, restaurant_id: restaurant.id } }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:destroy_params) { { id: menu.id, restaurant_id: restaurant.id } }

    it do
      expect { patch :destroy, params: destroy_params }.to change { Menu.count }.by(-1)
    end
  end
end
