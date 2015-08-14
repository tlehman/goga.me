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

  describe "#create_board" do
    let(:size) { 19 }

    it "creates a 19x19 Board for the Match" do
      match.create_board(size)
      expect(match.board).to be_a(Board)
      expect(match.board_size).to eq(size)
    end
  end

  describe "#joined?" do
    subject { match.joined? }
    it { is_expected.to eq(true) }

    context "when users are the same" do
      let(:white_user) { black_user }

      it { is_expected.to eq(false) }
    end
  end
end
