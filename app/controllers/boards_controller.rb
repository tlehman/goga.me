class BoardsController < ApplicationController
  before_filter :ensure_board
  attr_reader :board

  def show
    board_state = BoardPresenter.new(board).to_a
    match_show_board(board_state)
  end

  def update
    error_message = BoardService.attempt_move(x: x, y: y, user: current_user, board: board)
    board_state = BoardPresenter.new(board).to_a
    match_show_board(board_state, error_message)
    index_show_match_stats(id: board.id, move_count: board.moves.count)
  end

  private

  def match_show_board(board_state, error_message = nil)
    # WebsocketRails["match_#{board.match_id}".to_sym].trigger(:show_board, message: {
    #   board_state: board_state,
    #   current_turn_color: board.match.current_turn_color,
    #   error_message: error_message,
    # })
  end

  def index_show_match_stats(stats)
    #WebsocketRails[:match_index].trigger(:show_match_stats, message: stats)
  end

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
