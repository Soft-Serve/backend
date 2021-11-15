require 'rails_helper'

RSpec.describe DietaryInteractor::Destroy do
  let!(:dietary) { create(:dietary) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }

  subject do
    described_class.new(
      author: current_user,
      dietary: dietary
    ).call
  end

  it do
    expect(subject.successful?).to be(true)
  end
end
