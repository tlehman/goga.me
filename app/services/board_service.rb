module BoardService
  def self.attempt_move(x:, y:, user:, board:)
    return "user has no permission: not in match" if !in_match?(user, board.match)
    return "color is nil" if color(user, board).nil?
    return "coordinates invalid (cannot be nil)" if x.nil? || y.nil?
    return "point (#{x},#{y}) is out of bounds" if out_of_bounds?(x,y,board.size)

    board.play_move(x: x, y: y, color: color(user, board), user: user)
  end

  def self.out_of_bounds?(x,y,size)
    return false if x.floor != x || y.floor != y
    (x < 1 || y < 1) || (x > size || y > size)
  end

  def self.in_match?(user, match)
    user.id.in?([match.black_user_id, match.white_user_id])
  end

  def self.color(user, board)
    if !board.match.joined?
      return :black if board.last_move.nil?
      board.last_move.color.to_s == "white" ? :black : :white
    elsif user.id == board.match.black_user_id
      :black
    elsif user.id == board.match.white_user_id
      :white
    end
  end
end
