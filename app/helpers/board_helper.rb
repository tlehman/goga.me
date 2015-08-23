module BoardHelper
  OFFSET = 50

  def draw_board_svg(size:, width:)
    vertical = size.times.map do |i|
      x1 = OFFSET
      x2 = OFFSET + (width - width/size.to_f)

      y1 = OFFSET + i*width/size
      y2 = OFFSET + i*width/size
      "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" style=\"stroke:rgb(30,30,30);stroke-width:1\" />"
    end

    horizontal = size.times.map do |i|
      x1 = OFFSET + i*width/size
      x2 = OFFSET + i*width/size

      y1 = OFFSET
      y2 = OFFSET + (width - width/size.to_f)
      "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" style=\"stroke:rgb(30,30,30);stroke-width:1\" />"
    end

    (vertical + horizontal).join("\n")
  end

  def draw_grid_intersection_points(size:, width:)
    points = 1.upto(size).map do |yi|
      1.upto(size).map do |xi|
        x1 = OFFSET + (xi-1)*width/size
        y1 = OFFSET + (yi-1)*width/size

        "<circle id=\"#{xi}_#{yi}\" cx=\"#{x1}\" cy=\"#{y1}\" r=\"10\" onclick=\"handleMove(#{xi},#{yi})\" style=\"opacity:0;\" />"
      end
    end

    points.flatten.join("\n")
  end
end
