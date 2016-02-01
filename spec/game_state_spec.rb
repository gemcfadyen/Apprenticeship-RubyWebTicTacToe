require 'game_state'
require 'grid_formatter'
require 'player_symbols'

RSpec.describe GameState do
  it "valid moves contains symbol" do
    game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, "Draw")

    expect(game_state.valid_moves_includes?("X")).to be true
  end

  it "valid moves does contains symbol" do
    game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, "Draw")

    expect(game_state.valid_moves_includes?("9")).to be false
  end

  it "has no game status" do
    game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, nil)

    expect(game_state.status?).to be false
  end

  it "has game status" do
    game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, "Draw")
    expect(game_state.status?).to be true
  end

  it "flattens formatted_rows" do
    game_state = GameState.new(GridFormatter.new.format(Board.new), PlayerSymbols::all, "Draw")
   expect(game_state.flatten_rows).to eq [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end
end
