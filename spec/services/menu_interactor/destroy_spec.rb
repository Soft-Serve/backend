require 'rails_helper'

RSpec.describe MenuInteractor::Destroy do
  let!(:menu) { create(:menu) }
  let(:restaurant) { create(:restaurant) }
  let!(:current_user) { create(:user, restaurant: restaurant) }

  subject do
    described_class.new(
      author: current_user,
      menu: menu
    ).call
  end

  it do
    expect(subject.successful?).to be(true)
  end
end
