require 'rails_helper'

RSpec.describe DietaryInstancesController do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu) }
  let!(:menu_category) { create(:menu_category) }
  let!(:menu_item) { create(:menu_item) }
  let!(:dietary) { create(:dietary) }
  let!(:dietary_instance) { create(:dietary_instance) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:name) { 'soy' }
  let(:create_params) do
    {
      menu_item_id: menu_item.id,
      dietary_id: dietary&.id,
      menu_category_id: menu_category.id,
      menu_id: menu.id,
      restaurant_id: restaurant.id,
      current_user: current_user
    }
  end
  let(:id) { dietary_instance.id }
  let(:routing_params) do
    {
      id: id,
      menu_item_id: menu_item.id,
      menu_category_id: menu_category.id,
      menu_id: menu.id,
      dietary_id: dietary.id,
      restaurant_id: restaurant.id,
      current_user: current_user
    }
  end

  def json
    JSON.parse(response.body)
  end

  describe 'POST #create' do
    before { post :create, params: create_params }

    context 'when params are valid' do
      it do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when params are invalid' do
      let(:dietary) { nil }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    it do
      expect { patch :destroy, params: routing_params }.to change { DietaryInstance.count }.by(-1)
    end
  end
end
