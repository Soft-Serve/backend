require 'rails_helper'

RSpec.describe RestaurantInteractor::Destroy do
  let!(:restaurant) { create(:restaurant) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }

  subject do
    described_class.new(
      author: current_user,
      restaurant: restaurant
    ).call
  end

  it do
    expect(subject.successful?).to be(true)
  end
end
