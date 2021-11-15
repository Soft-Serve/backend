require 'rails_helper'

RSpec.describe ItemSizesController do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu) }
  let!(:menu_category) { create(:menu_category) }
  let!(:menu_item) { create(:menu_item) }
  let!(:item_size) { create(:item_size) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:price) { 9 }
  let(:unit) { '6 oz' }
  let(:create_params) do
    {
      price: price,
      unit: unit,
      menu_item_id: menu_item.id,
      menu_category_id: menu_category.id,
      menu_id: menu.id,
      restaurant_id: restaurant.id
    }
  end
  let(:id) { item_size.id }
  let(:routing_params) do
    {
      id: id,
      menu_item_id: menu_item.id,
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
        expect(json['price']).to eq(9)
      end
    end

    context 'when params are invalid' do
      let(:price) { nil }

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
      let(:update_params) { { price: 8 } }
      it do
        expect(json['price']).to eq(8)
      end
    end

    context 'when params are invalid' do
      let(:update_params) { { price: nil } }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    it do
      expect { patch :destroy, params: routing_params }.to change { ItemSize.count }.by(-1)
    end
  end
end
