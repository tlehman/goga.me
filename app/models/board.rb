class Board < ActiveRecord::Base
  belongs_to :match
  has_many :moves

  def play_move(x:, y:, color:, user:)
    move = Move.new(x: x, y: y, color: color, user: user)
    return if color_same_as_last_move?(color)
    return if position_occupied?(x:x, y:y)
    moves << move
  end

  def position_occupied?(x:, y:)
    moves.where(x:x, y:y).count > 0
  end

  def position(x:, y:) 
    moves.where(x:x, y:y).first
  end

  def color_same_as_last_move?(color)
    return false if moves.empty?

    last_move.color == color.to_s
  end

  def last_move
    moves.order("created_at ASC").last
  end
end

