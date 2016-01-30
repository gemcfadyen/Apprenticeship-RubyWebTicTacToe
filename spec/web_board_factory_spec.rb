require 'web_board_factory'
require 'web_display_to_board_adapter'

RSpec.describe WebBoardFactory do

  it "creates empty board" do
    expect(WebBoardFactory.new(WebDisplayToBoardAdapter.new).create_board(nil).empty?).to be true
  end

  it "creates a board with given formation" do
    grid_param = "[:X, :O, 3, :X, :O, 6, 7, 8, 9]"

    expect(WebBoardFactory.new(WebDisplayToBoardAdapter.new).create_board(grid_param).grid_for_display).to eq [[:X, :O, nil], [PlayerSymbols::X, PlayerSymbols::O, nil], [nil, nil, nil]]
  end
end
