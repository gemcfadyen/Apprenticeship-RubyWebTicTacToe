require 'web_board_displayer'
require 'player_symbols'

RSpec.describe WebBoardDisplayer do

  it "displays empty board as numbers" do
    web_display = WebBoardDisplayer.new

    expect(web_display.format(Board.new)).to eq [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  it "displays board with empty cells as numbers" do
    web_display = WebBoardDisplayer.new
    board = Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, nil, nil, nil])
    expect(web_display.format(board)).to eq [[PlayerSymbols::X, 2, 3], [PlayerSymbols::O, 5, 6], [7, 8, 9]]
  end
end


