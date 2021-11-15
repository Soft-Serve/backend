require 'rails_helper'

RSpec.describe RestaurantInteractor::Create do
  let!(:restaurant) { create(:restaurant) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:params) do
    {
      name: 'Akira Back',
      colour: 'red',
      tint: 400,
      currency: 'CAD',
      slug: 'akiraback'
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
      expect { subject }.to change {  Restaurant.count }.by(1)
      expect(subject.successful?).to be(true)
    end
  end
end
