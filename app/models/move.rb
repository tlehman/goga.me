class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  enum color: { black: 0, white: 1 }

  def to_h
    {x: x, y: y, color: color.to_s}
  end
end
