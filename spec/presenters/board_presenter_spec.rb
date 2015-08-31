require 'rails_helper'

RSpec.describe BoardPresenter do
  let(:blank) { Move.colors["blank"] }
  let(:black) { Move.colors["black"] }
  let(:white) { Move.colors["white"] }
  let(:board) { FactoryGirl.create(:board, size: 5) }
  let(:white_user) { board.match.white_user }
  let(:black_user) { board.match.black_user }
  let(:presenter) { described_class.new(board) }
  Point = described_class::Point

  context "when finding neighboring components" do
    let(:board) { FactoryGirl.create(:board, size: 9) }

    before(:each) do
      board.play_move(x: 2, y: 2, color: :black, user: black_user)
      board.play_move(x: 7, y: 7, color: :white, user: white_user)
      board.play_move(x: 4, y: 3, color: :black, user: black_user)
      board.play_move(x: 7, y: 7, color: :white, user: white_user)
      board.play_move(x: 3, y: 2, color: :black, user: black_user)
      board.play_move(x: 7, y: 6, color: :white, user: white_user)
      board.play_move(x: 2, y: 3, color: :black, user: black_user)
      board.play_move(x: 3, y: 3, color: :white, user: white_user)
      board.play_move(x: 2, y: 4, color: :black, user: black_user)
      board.play_move(x: 6, y: 7, color: :white, user: white_user)
      board.play_move(x: 3, y: 4, color: :black, user: black_user)
      board.play_move(x: 4, y: 4, color: :white, user: white_user)
    end

    describe "State" do
      describe "neighbors" do
        it "picks all neighbors of the same color" do
          u = Point.new(2,3,black)
          expect(presenter.state.neighbors(u)).to eq(Set.new([
            Point.new(2,2,black),
            Point.new(2,3,black),
            Point.new(2,4,black),
          ]))
        end
      end
    end

    it "computes the correct state" do
      expect(presenter.state.to_a).to eq(
        [[0,0,0,0,0,0,0,0,0],
         [0,1,0,0,0,0,0,0,0],
         [0,1,2,1,0,0,0,0,0],
         [0,1,1,2,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,2,0,0],
         [0,0,0,0,0,2,2,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0]]
      )
    end

    describe "#find_component_containing" do
      it "finds the connected component for a given point" do
        u = Point.new(2,2,black)
        expect(presenter.find_component_containing(u)).to eq(Set.new([
          Point.new(2,2,black),
          Point.new(2,3,black),
          Point.new(2,4,black),
          Point.new(3,4,black),
        ]))
      end
    end

    describe "#components_adjacent_to_last_move" do
      let(:black_top) { Set.new([Point.new(4,3,black)]) }
      let(:black_left) {
        Set.new(
          [
            Point.new(2,2,black),
            Point.new(2,3,black),
            Point.new(2,4,black),
            Point.new(3,4,black),
      ])
      }

      it "returns the similar connected components of the adjacent pieces" do
        expected_components = Set.new([black_left, black_top])
        expect(presenter.components_adjacent_to_last_move).to eq(expected_components)
      end
    end
  end

  describe "#state" do
    let(:board) { FactoryGirl.create(:board, size: 9) }
    let(:empty_state) {
        [[0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0]]
    }

    it "is empty" do
      expect(presenter.state.to_a).to eq(empty_state)
    end

    it "represents blank as 0, black as 1 and white as 2" do
      board.play_move(x: 2, y: 2, color: :black, user: black_user)
      board.play_move(x: 8, y: 2, color: :white, user: white_user)
      board.play_move(x: 2, y: 3, color: :black, user: black_user)
      expect(presenter.state.to_a).to eq(
        [[0,0,0,0,0,0,0,0,0],
         [0,1,0,0,0,0,0,2,0],
         [0,1,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0]]
      )
    end

    it "represents the state correctly" do
      board.play_move(x: 4, y: 5, color: :black, user: black_user)
      board.play_move(x: 5, y: 5, color: :white, user: white_user)
      board.play_move(x: 9, y: 4, color: :black, user: black_user)
      board.play_move(x: 4, y: 4, color: :white, user: white_user)
      board.play_move(x: 8, y: 4, color: :black, user: black_user)
      board.play_move(x: 3, y: 5, color: :white, user: white_user)
      board.play_move(x: 8, y: 5, color: :black, user: black_user)
      expect(presenter.state.to_a).to eq(
        [[0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,2,0,0,0,1,1],
         [0,0,2,1,2,0,0,1,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0]]
      )
    end

  end

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
