class Board < ActiveRecord::Base
  belongs_to :match
  delegate :state, to: :presenter
  has_many :moves

  def play_move(x:, y:, color:, user:)
    move = Move.new(x: x, y: y, color: color, user: user)
    return "color same as last"       if color_same_as_last_move?(color)
    return "position occupied"        if position_occupied?(x:x, y:y)
    # FIXME: Self capture code prevents any moves from being played
    return "self capture not allowed" if play_would_self_capture?(x,y,color)
    moves << move
    capture_surrounded_groups
    return "no error: #{moves.count} moves"
  end

  def capture_moves_at(points)
    points.each do |point|
      moves.create(x: point.x, y: point.y)
    end
  end

  def position(x:, y:)
    moves.where(x:x, y:y).first
  end

  def color_same_as_last_move?(color)
    return false if moves.empty? || !match.joined?

    last_move.color == color.to_s
  end

  def last_move
    moves.where("color != 0").order("created_at ASC").last
  end

  def capture_surrounded_groups
    presenter.components_opposite_color_of_last_move.each do |component|
      if presenter.state.total_liberties(component) == 0
        capture_moves_at(component.to_a)
      end
    end
  end

  def presenter
    @presenter ||= BoardPresenter.new(self)
  end

  private

  def position_occupied?(x:, y:)
    state.get(x,y) != Move.colors["blank"]
  end

  def play_would_self_capture?(x,y,color)
    point = Point.new(x,y,Move.colors[color.to_s])
    state.enemy_neighbors(point).count == 4  # <--- 2*(number of dimensions)
  end

end

