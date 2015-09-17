require 'rails_helper'

RSpec.describe Move, type: :model do
  describe "#opposite_color" do
    it "returns black when it is white" do
      expect(Move.new(color: :white).opposite_color).to eq(:black)
    end

    it "returns white when it is black" do
      expect(Move.new(color: :black).opposite_color).to eq(:white)
    end

    it "returns blank when it is blank" do
      expect(Move.new(color: :blank).opposite_color).to eq(:blank)
    end

  end
end
