require 'board'
require 'player_symbols'

RSpec.describe Board do
  X = PlayerSymbols::X
  O = PlayerSymbols::O

  let (:board) {Board.new}

  it "is empty on initialisation" do
    expect(board.empty?).to be true
  end

  it "is not empty when all slots are occupied" do
    full_board = Board.new([X, O, X, O, X, O, X, X, O])
    expect(full_board.empty?).to be false
  end

  it "returns the current grid formation" do
    board = Board.new([nil, nil, nil, nil, X, O, nil, nil, nil])
    expect(board.grid_for_display).to eq([[nil, nil, nil], [nil, X, O], [nil, nil, nil]])
  end

  it "can get symbol at given position" do
    board = Board.new([nil, nil, nil, nil, X, O, nil, nil, nil])
    expect(board.get_symbol_at(4)).to be :X
  end

  it "can be updated at a given position" do
    updated_board = board.make_move(1, X)
    expect(updated_board.get_symbol_at(1)).to eq(X)
  end

  it "has free spaces" do
    expect(board.free_spaces?).to be true
  end

  it "has no free spaces when all slots are occupied" do
    full_board = Board.new([X, O, X, O, X, O, X, X, O])
    expect(full_board.free_spaces?).to be false
  end

  it "has no winning combination" do
    winning_board = Board.new([O, X, X, nil, nil, nil, nil, nil, nil])
    expect(winning_board.winning_combination?).to be false
  end

  it "has winning combination of X in top row" do
    winning_board = Board.new([X, X, X, nil, nil, nil, nil, nil, nil])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of X in middle row" do
    winning_board = Board.new([nil, nil, nil, X, X, X, nil, nil, nil])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of X in bottom row" do
    winning_board = Board.new([nil, nil, nil, nil, nil, nil, X, X, X])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of X in left column" do
    winning_board = Board.new([X, nil, nil, X, nil, nil, X, nil, nil])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of X in middle column" do
    winning_board = Board.new([nil, X, nil, nil, X, nil, nil, X, nil])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of X in right column" do
    winning_board = Board.new([nil, nil, X, nil, nil, X, nil, nil, X])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of X in first diagonal" do
    winning_board = Board.new([X, nil, nil, nil, X, nil, nil, nil, X])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of X in second diagonal" do
    winning_board = Board.new([nil, nil, X, nil, X, nil, X, nil, nil])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of O in top row" do
    winning_board = Board.new([O, O, O, nil, nil, nil, nil, nil, nil])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of O in left column" do
    winning_board = Board.new([O, nil, nil, O, nil, nil, O, nil, nil])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning combination of O in first diagonal" do
    winning_board = Board.new([O, nil, nil, nil, O, nil, nil, nil, O])
    expect(winning_board.winning_combination?).to be true
  end

  it "has winning symbol X" do
    winning_board = Board.new([X, X, X, nil, nil, nil, nil, nil, nil])
    expect(winning_board.winning_symbol).to be X
  end

  it "has winning symbol O" do
    winning_board = Board.new([O, O, O, nil, nil, nil, nil, nil, nil])
    expect(winning_board.winning_symbol).to be O
  end

  it "has no winning symbol" do
    expect(board.winning_symbol).to be nil
  end

  it "gives all vacant indices on an empty board" do
    expect(board.vacant_indices).to include(0, 1, 2, 3, 4, 5, 6, 7, 8)
  end

  it "gives all vacant indices on a board with moves" do
    board = Board.new([X, nil, O, nil, nil, nil, nil, nil, nil])
    expect(board.vacant_indices).not_to include(0, 2)
  end
end
