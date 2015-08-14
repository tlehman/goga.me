require 'spec_helper'

RSpec.describe BoardHelper do

<<-BOARD
. . .
. . .
. . .
BOARD

  describe "#draw_board_svg" do
    let(:width) { 300 }
    let(:size) { 3 }

    it "outputs six lines" do
      expect(draw_board_svg(size: size, width: width)).to eq(<<EOL
<line x1="0" y1="0"   x2="300" y2="0"   style="stroke:rgb(0,0,0);stroke-width:2" />
<line x1="0" y1="150" x2="300" y2="150" style="stroke:rgb(0,0,0);stroke-width:2" />
<line x1="0" y1="300" x2="200" y2="300" style="stroke:rgb(0,0,0);stroke-width:2" />

<line x1="0" y1="0" x2="200" y2="200" style="stroke:rgb(0,0,0);stroke-width:2" />
<line x1="0" y1="0" x2="200" y2="200" style="stroke:rgb(0,0,0);stroke-width:2" />
<line x1="0" y1="0" x2="200" y2="200" style="stroke:rgb(0,0,0);stroke-width:2" />
EOL
)
    end
 end
