require 'grid_formatter'
require 'player_symbols'

RSpec.describe GridFormatter do
  let(:converter) { GridFormatter.new }

  it "converts empty board to one indexed" do
    expect(converter.format(Board.new)).to eq [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  end

  it "converts the empty cells in a board with moves to one indexed" do
    board = Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, nil, nil, nil, nil, nil])
    expect(converter.format(board)).to eq [[PlayerSymbols::X, 1, 2], [PlayerSymbols::O, 4, 5], [6, 7, 8]]
  end

  it "leaves board that is already one indexed as it is" do
board = Board.new([PlayerSymbols::X, 1, 2, PlayerSymbols::O, 4, 5, 6, 7, 8])
    expect(converter.format(board)).to eq [[PlayerSymbols::X, 1, 2], [PlayerSymbols::O, 4, 5], [6, 7, 8]]
  end
end
