require 'rails_helper'

RSpec.describe BoardPresenter do
  let(:board) { FactoryGirl.create(:board, size: 5) }
  let(:white_user) { board.match.white_user }
  let(:black_user) { board.match.black_user }
  let(:presenter) { described_class.new(board) }

  describe "#to_a" do

    it "is empty at first" do
      expect(presenter.to_a).to eq([])
    end

    it "has one point after one play" do
      board.play_move(x:1, y:1, color: :black, user: black_user)
      expect(presenter.to_a).to eq([{x:1, y:1, color:'black'}])
    end

    it "has two points after two plays" do
      board.play_move(x:1, y:1, color: :black, user: black_user)
      board.play_move(x:2, y:1, color: :white, user: white_user)
      expect(presenter.to_a).to eq(
        [
          {x:1, y:1, color:'black'},
          {x:2, y:1, color:'white'},
        ]
      )
    end

    it "has three points after three plays" do
      board.play_move(x:1, y:1, color: :black, user: black_user)
      board.play_move(x:2, y:1, color: :white, user: white_user)
      board.play_move(x:2, y:2, color: :black, user: black_user)
      expect(presenter.to_a).to eq(
        [
          {x:1, y:1, color:'black'},
          {x:2, y:1, color:'white'},
          {x:2, y:2, color:'black'},
        ]
      )
    end



  end

end
