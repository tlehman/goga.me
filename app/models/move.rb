class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  enum color: { blank: 0, black: 1, white: 2 }

  def opposite_color
    return :blank if color.to_s == "blank"

    (color.to_s == "black") ? :white : :black
  end

  def to_h
    {x: x, y: y, color: color.to_s}
  end
end
