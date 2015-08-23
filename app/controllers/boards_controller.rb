class BoardsController < WebsocketRails::BaseController
  before_filter :ensure_board
  attr_reader :board

  def show
    board_state = BoardPresenter.new(board).to_a
    send_message('show_board', message: {board_state: board_state})
  end

  def update
    error_message = BoardService.attempt_move(x: x, y: y, user: current_user, board: board)
    board_state = BoardPresenter.new(board).to_a

    send_message('show_board', message: {error_message: error_message, board_state: board_state})
  end

  private

  def x
    message[:x]
  end

  def y
    message[:y]
  end

  def ensure_board
    @board ||= Board.find_by(match_id: message[:match_id])
  end
end
