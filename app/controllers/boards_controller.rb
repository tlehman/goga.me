class BoardsController < WebsocketRails::BaseController
  before_filter :ensure_board
  attr_reader :board

  def update
    x = message[:x]
    y = message[:y]
    user = User.find_by(id: message[:user_id])
    board.play_move(x: x, y: y, color: color, user: current_user)
    move = board.position(x: x, y: y)
    if move.nil?
      send_message('show_board', message: {x: x, y: y, user_id: current_user.id})
    end
  end

  private

  def board
    @board ||= Board.find_by(match_id: message[:match_id])
  end
end
