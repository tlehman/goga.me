class BoardsController < WebsocketRails::BaseController
  def update
    board = Board.find_by(match_id: message[:match_id])
    x = message[:x]
    y = message[:y]
    color = :black
    board.play_move(x: x, y: y, color: color, user: current_user)
    move = board.position(x: x, y: y)
    if move.nil?
      send_message('show_board', message: {x: x, y: y})
    end
  end
end
