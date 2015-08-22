class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  enum color: { black: 0, white: 1 }
  COLOR_CHARS = { black: 'b', white: 'w' }

  def to_c
    COLOR_CHARS[color]
  end
end
