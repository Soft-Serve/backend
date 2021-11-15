require 'rails_helper'

RSpec.describe MenuInteractor::Update do
  let!(:menu) { create(:menu) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:params) { { name: 'Lunch Menu' } }

  subject do
    described_class.new(
      params: params,
      menu: menu,
      author: current_user
    ).call
  end

  context 'when params are valid' do
    it do
      expect(subject.successful?).to be(true)
      expect(subject.value.name).to eq('Lunch Menu')
    end
  end

  context 'when params are invalid' do
    let(:params) { { name: nil } }

    it do
      expect(subject.successful?).to be(false)
      expect(subject.errors).to eq(
        errors: ["Validation failed: Name can't be blank"]
      )
    end
  end
end
