require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:black_user) { FactoryGirl.create(:user) }
  let(:white_user) { FactoryGirl.create(:user) }
  let(:match) { FactoryGirl.create(:match, black_user: black_user, white_user: white_user) }

  it "sets up the associations correctly" do
    expect(match.black_user).to eq(black_user)
    expect(match.white_user).to eq(white_user)
    expect(black_user.black_matches).to include(match)
    expect(white_user.white_matches).to include(match)
  end
end
