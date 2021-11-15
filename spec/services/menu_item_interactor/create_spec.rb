require 'rails_helper'

RSpec.describe MenuItemInteractor::Create do
  let(:menu_category) { create(:menu_category) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:name) { 'Crema Catalana' }
  let(:item_params) do
    {
      name: name,
      menu_category_id: menu_category.id
    }
  end

  let(:size_params) { { sizes: [ unit: 'one', price: 10 ] } }

  subject do
    described_class.new(
      item_params: item_params,
      size_params: size_params,
      author: current_user
    ).call
  end

  context 'when params are valid' do
    it do
      expect { subject }.to change {  MenuItem.count }.by(1)
      expect(subject.successful?).to be(true)
    end
  end

  context 'when params are invalid' do
    let(:name) { nil }
    it do
      expect(subject.successful?).to be(false)
      expect(subject.errors).to eq(
        errors: ["Validation failed: Name can't be blank"]
      )
    end
  end
end
