require 'rails_helper'

RSpec.describe DietaryInstanceInteractor::Create do
  let!(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item) }
  let(:dietary) { create(:dietary) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:params) do
    {
      dietary_id: dietary&.id,
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
      expect { subject }.to change {  DietaryInstance.count }.by(1)
      expect(subject.successful?).to be(true)
    end
  end

  context 'when params are invalid' do
    let(:dietary) { nil }
    it do
      expect(subject.successful?).to be(false)
      expect(subject.errors).to eq(
        errors: ["Validation failed: Dietary must exist, Dietary can't be blank"]
      )
    end
  end
end
