require 'rails_helper'

RSpec.describe 'BoardsController' do
  let(:board) { FactoryGirl.create(:board, size: 5) }
  let(:current_user) { FactoryGirl.create(:user) }

  describe "#update" do
    context "when user_id matches current_user.id" do
      context "and position is empty" do
        let(:x) { 2 }
        let(:y) { 2 }

        it "should create a new move" do
          expect {
            create_event('update_board', message:{x: x, y: y, user_id: current_user.id, match_id: board.match_id})
          }.to change(board.moves, :count).by(1)
        end

        it "sends the new board state to the client" do
          create_event('update_board', message:{x: x, y: y, user_id: current_user.id, match_id: board.match_id})
          expect(controller).to receive(:send_message).with('show_board')
        end

      end
    end
  end
end
