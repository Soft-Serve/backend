require 'rails_helper'

RSpec.describe MenuCategoryInteractor::Destroy do
  let!(:menu_category) { create(:menu_category) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }

  subject do
    described_class.new(
      author: current_user,
      menu_category: menu_category
    ).call
  end

  it do
    expect(subject.successful?).to be(true)
  end
end
