require 'rails_helper'

RSpec.describe MenuItemInteractor::Update do
  let!(:menu_item) { create(:menu_item) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:item_params) { { name: 'Potstickers' } }

  subject do
    described_class.new(
      item_params: item_params,
      size_params: {},
      menu_item: menu_item,
      author: current_user
    ).call
  end

  context 'when params are valid' do
    it do
      expect(subject.successful?).to be(true)
      expect(subject.value.name).to eq('Potstickers')
    end
  end

  context 'when params are invalid' do
    let(:item_params) { { name: nil } }

    it do
      expect(subject.successful?).to be(false)
      expect(subject.errors).to eq(
        errors: ["Validation failed: Name can't be blank"]
      )
    end
  end
end
