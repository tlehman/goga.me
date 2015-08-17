require 'rails_helper'

RSpec.describe BoardHelper do
  let(:width) { 300 }
  let(:size) { 3 }

  describe "#draw_board_svg" do
    it "outputs six lines" do
      expect(draw_board_svg(size: size, width: width).split("\n").count).to eq(6)
    end
  end

  describe "#draw_grid_intersection_points" do
    it "outputs nine grid intersection points" do
      expect(draw_grid_intersection_points(size: size, width: width).split("\n").count).to eq(9)
    end
  end

end
