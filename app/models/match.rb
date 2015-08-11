class Match < ActiveRecord::Base
  belongs_to :black_user, class_name: "User", foreign_key: :black_user_id
  belongs_to :white_user, class_name: "User", foreign_key: :white_user_id
  has_one :board

  delegate :email, to: :black_user, prefix: true, allow_nil: true
  delegate :email, to: :white_user, prefix: true, allow_nil: true
  delegate :width, to: :board, prefix: true, allow_nil: true

  def joined?
    black_user_id != white_user_id
  end

  def create_board(width = 19)
    return unless board.nil?

    self.board = Board.create(width: width, match_id: self.id)
  end
end
