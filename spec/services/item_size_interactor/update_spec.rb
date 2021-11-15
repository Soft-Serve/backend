require 'rails_helper'

RSpec.describe ItemSizeInteractor::Update do
  let!(:item_size) { create(:item_size) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:params) { { price: 8 } }

  subject do
    described_class.new(
      params: params,
      item_size: item_size,
      author: current_user
    ).call
  end

  context 'when params are valid' do
    it do
      expect(subject.successful?).to be(true)
      expect(subject.value.price).to eq(8)
    end
  end

  context 'when params are invalid' do
    let(:params) { { price: nil } }

    it do
      expect(subject.successful?).to be(false)
      expect(subject.errors).to eq(
        errors: ["Validation failed: Price can't be blank"]
      )
    end
  end
end
