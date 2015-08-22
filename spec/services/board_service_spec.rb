require 'rails_helper'

RSpec.describe BoardService do
  let(:black_user) { FactoryGirl.create(:user) }
  let(:white_user) { FactoryGirl.create(:user) }
  let(:match) { FactoryGirl.create(:match, black_user: black_user, white_user: white_user) }
  let(:board) { match.create_board(9) }
  subject(:service) { described_class }

  describe ".attempt_move" do
    it "determines the user's color" do
      service.attempt_move(x: 1, y: 1, user: black_user, board: board)

      expect(board).to receive(:play_move).with(x: 1, y: 2, user: white_user, color: :white)
      service.attempt_move(x: 1, y: 2, user: white_user, board: board)

      expect(board).to receive(:play_move).with(x: 2, y: 2, user: black_user, color: :black)
      service.attempt_move(x: 2, y: 2, user: black_user, board: board)
    end

    it "plays the move" do
      expect {
        service.attempt_move(x: 1, y: 1, user: black_user, board: board)
      }.to change(board.moves, :count).by(1)
    end

    context "when x,y is out of bounds" do
      it "returns an out of bounds error" do
        expect(service.attempt_move(x: -1, y: -1, user: black_user, board: board)).to eq(
          "point (-1,-1) is out of bounds")
        expect(service.attempt_move(x: 1, y: board.size+1, user: black_user, board: board)).to eq(
          "point (1,10) is out of bounds")
      end
    end

    context "when x or y is nil" do
      it "returns an invalid coordinate error" do
        expect(service.attempt_move(x: nil, y: 2, user: black_user, board: board)).to eq(
          "coordinates invalid (cannot be nil)")
      end
    end

  end

end
