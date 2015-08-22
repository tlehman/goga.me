module BoardService
  module_function

  def attempt_move(x:, y:, user:, board:)
    return "coordinates invalid (cannot be nil)" if x.nil? || y.nil?
    return "point (#{x},#{y}) is out of bounds" if out_of_bounds?(x,y,board.size)

    board.play_move(x: x, y: y, color: color(user, board), user: user)
  end

  def out_of_bounds?(x,y,size)
    return false if x.floor != x || y.floor != y
    (x < 1 || y < 1) || (x > size || y > size)
  end

  def color(user, board)
    if user.id == board.match.black_user_id
      :black
    elsif user.id == board.match.white_user_id
      :white
    end
  end

end
