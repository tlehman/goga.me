class BoardsController < WebsocketRails::BaseController
  before_filter :ensure_board
  attr_reader :board

  def update
    error = BoardService.attempt_move(x, y, current_user, board)
    board_state = BoardPresenter.new(board).to_a

    send_message('show_board', message: {error: error, board_state: board_state})
  end

  private

  def x
    message[:x]
  end

  def y
    message[:h]
  end

  def ensure_board
    @board ||= Board.find_by(match_id: message[:match_id])
  end
end
