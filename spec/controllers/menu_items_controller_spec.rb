require 'rails_helper'

RSpec.describe MenuItemsController do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu) }
  let!(:menu_category) { create(:menu_category) }
  let!(:menu_item) { create(:menu_item) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:name) { 'Albarino' }
  let(:description) { 'Rio Baixas, 2018' }
  let(:create_params) do
    {
      name: name,
      description: description,
      menu_category_id: menu_category.id,
      menu_id: menu.id,
      restaurant_id: restaurant.id,
      sizes: [unit: 'one', price: 10]
    }
  end
  let(:id) { menu_item.id }
  let(:routing_params) do
    {
      id: id,
      menu_category_id: menu_category.id,
      menu_id: menu.id,
      restaurant_id: restaurant.id
    }
  end

  def json
    JSON.parse(response.body)
  end

  describe 'GET #show' do
    before { get :show, params: routing_params }

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
    before { post :create, params: create_params }

    context 'when params are valid' do
      it do
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('Albarino')
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
    before { patch :update, params: routing_params.merge(update_params) }

    context 'when params are valid' do
      let(:update_params) { { name: 'Pinot Noir' } }
      it do
        expect(json['name']).to eq('Pinot Noir')
      end
    end

    context 'when params are invalid' do
      let(:update_params) { { name: nil } }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    it do
      expect { patch :destroy, params: routing_params }.to change { MenuItem.count }.by(-1)
    end
  end
end
