class Match < ActiveRecord::Base
  belongs_to :black_user, class_name: "User", foreign_key: :black_user_id
  belongs_to :white_user, class_name: "User", foreign_key: :white_user_id
  has_one :board

  delegate :email, to: :black_user, prefix: true, allow_nil: true
  delegate :email, to: :white_user, prefix: true, allow_nil: true

  def joined?
    black_user_id != white_user_id
  end

  def board_size
    if board.nil?
      create_board
      reload
    end

    board.size
  end

  def create_board(size = 19)
    return board if board.present?

    self.board = Board.create(size: size, match_id: self.id)
  end
end
