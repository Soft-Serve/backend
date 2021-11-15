require 'rails_helper'

RSpec.describe MenuItemInteractor::Destroy do
  let!(:menu_item) { create(:menu_item) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }

  subject do
    described_class.new(
      author: current_user,
      menu_item: menu_item
    ).call
  end

  it do
    expect(subject.successful?).to be(true)
  end
end
