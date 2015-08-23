class BoardPresenter
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def to_a
    board.moves.map(&:to_h)
  end
end
