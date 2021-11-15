require 'rails_helper'

RSpec.describe DietaryInstanceInteractor::Destroy do
  let!(:restaurant) { create(:restaurant) }
  let!(:dietary_instance) { create(:dietary_instance) }
  let!(:current_user) { create(:user, restaurant: restaurant) }

  subject do
    described_class.new(
      author: current_user,
      dietary_instance: dietary_instance
    ).call
  end

  it do
    expect(subject.successful?).to be(true)
  end
end
