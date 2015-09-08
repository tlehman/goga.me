class Match < ActiveRecord::Base
  belongs_to :black_user, class_name: "User", foreign_key: :black_user_id
  belongs_to :white_user, class_name: "User", foreign_key: :white_user_id
  has_one :board

  delegate :email, to: :black_user, prefix: true, allow_nil: true
  delegate :email, to: :white_user, prefix: true, allow_nil: true
  delegate :size, to: :board, prefix: true, allow_nil: true

  def joined?
    black_user_id != white_user_id
  end

  def create_board(size = 19)
    return board if board.present?

    self.board = Board.create(size: size, match_id: self.id)
  end

  def current_turn_user_id
    return self.black_user_id if board.last_move.nil?
    (board.last_move.color == "black") ? self.white_user_id : self.black_user_id
  end

  def current_turn_color
    (current_turn_user_id == black_user_id) ? :black : :white
  end


end
