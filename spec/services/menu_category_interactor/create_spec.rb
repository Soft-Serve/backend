require 'rails_helper'

RSpec.describe MenuCategoryInteractor::Create do
  let(:menu) { create(:menu) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }
  let(:name) { 'Wines' }
  let(:category_type) { 'beverage' }
  let(:params) do
    {
      name: name,
      category_type: category_type,
      menu_id: menu.id
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
      expect { subject }.to change {  MenuCategory.count }.by(1)
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
