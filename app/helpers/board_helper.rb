module BoardHelper
  def draw_board_svg(size:, width:)
    vertical = size.times.map do |i|
      x1 = 0
      x2 = (width - width/size.to_f)

      y1 = i*width/size
      y2 = i*width/size
      "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" style=\"stroke:rgb(30,30,30);stroke-width:1\" />"
    end

    horizontal = size.times.map do |i|
      x1 = i*width/size
      x2 = i*width/size

      y1 = 0
      y2 = (width - width/size.to_f)
      "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" style=\"stroke:rgb(30,30,30);stroke-width:1\" />"
    end

    (vertical + horizontal).join("\n")
  end
end
