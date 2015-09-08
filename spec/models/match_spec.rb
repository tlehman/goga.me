require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:black_user) { FactoryGirl.create(:user) }
  let(:white_user) { FactoryGirl.create(:user) }
  let(:match) { FactoryGirl.create(:match, black_user: black_user, white_user: white_user) }
  let(:board) { match.board }
  let(:size) { 19 }

  before do
    match.create_board(size)
  end

  it "sets up the associations correctly" do
    expect(match.black_user).to eq(black_user)
    expect(match.white_user).to eq(white_user)
    expect(black_user.black_matches).to include(match)
    expect(white_user.white_matches).to include(match)
  end

  describe "#create_board" do
    let(:match) { FactoryGirl.create(:match, black_user: black_user, white_user: white_user) }

    it "creates a 19x19 Board for the Match" do
      match.create_board(size)
      expect(match.board).to be_a(Board)
      expect(match.board_size).to eq(size)
    end
  end

  describe "#current_turn_color" do
    it "returns the black user before any moves have been made" do
      expect(match.board.moves.count).to eq(0)
      expect(match.current_turn_color).to eq(:black)
    end

    it "returns the white user after black has played" do
      board.play_move(x:1, y:1, color: :black, user: black_user)
      expect(match.current_turn_color).to eq(:white)
    end

    it "returns the black user after white has played" do
      board.play_move(x:1, y:1, color: :black, user: black_user)
      board.play_move(x:1, y:2, color: :white, user: white_user)
      expect(match.current_turn_color).to eq(:black)
    end
  end


  describe "#current_turn_user_id" do
    it "returns the black user before any moves have been made" do
      expect(match.board.moves.count).to eq(0)
      expect(match.current_turn_user_id).to eq(black_user.id)
    end

    it "returns the white user after black has played" do
      board.play_move(x:1, y:1, color: :black, user: black_user)
      expect(match.current_turn_user_id).to eq(white_user.id)
    end

    it "returns the black user after white has played" do
      board.play_move(x:1, y:1, color: :black, user: black_user)
      board.play_move(x:1, y:2, color: :white, user: white_user)
      expect(match.current_turn_user_id).to eq(black_user.id)
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
