require 'rails_helper'

RSpec.describe ItemSizeInteractor::Create do
  let(:menu_item) { create(:menu_item) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:price) { 8 }
  let(:unit) { '6 potstickers' }
  let(:params) do
    {
      price: price,
      unit: unit,
      menu_item_id: menu_item.id
    }
  end

  subject do
    described_class.new(
      params: params,
      author: current_user
    ).call
  end

  context 'when params are valid' do
    it do
      expect { subject }.to change {  ItemSize.count }.by(1)
      expect(subject.successful?).to be(true)
    end
  end

  context 'when params are invalid' do
    let(:price) { nil }
    it do
      expect(subject.successful?).to be(false)
      expect(subject.errors).to eq(
        errors: ["Validation failed: Price can't be blank"]
      )
    end
  end
end
