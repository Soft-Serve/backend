require 'rails_helper'

RSpec.describe RestaurantInteractor::Update do
  let!(:restaurant) { create(:restaurant) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:params) { { name: 'Akira Back' } }

  subject do
    described_class.new(
      params: params,
      restaurant: restaurant,
      author: current_user
    ).call
  end

  context 'when params are valid' do
    it do
      expect(subject.successful?).to be(true)
      expect(subject.value.name).to eq('Akira Back')
    end
  end

  context 'when params are invalid' do
    let(:params) { { currency: 'cadadwe' } }

    it do
      expect(subject.successful?).to be(false)
      expect(subject.errors).to eq(
        errors: ['Validation failed: Currency is not included in the list']
      )
    end
  end
end
