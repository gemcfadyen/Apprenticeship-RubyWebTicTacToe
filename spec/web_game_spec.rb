require 'web_game'

RSpec.describe WebGame do
  let(:web_game) { WebGame.new }
  it "updates empty board at given index with player X symbol" do
    updated_board = web_game.make_move(Board.new, 1)
    expect(updated_board.get_symbol_at(1)).to eq PlayerSymbols::X
  end

  it "updates the board at given index with player O symbol" do
    board = Board.new([PlayerSymbols::X, nil, nil, nil, nil, nil, nil,nil, nil])
    updated_board = web_game.make_move(board, 3)
    expect(updated_board.get_symbol_at(3)).to eq PlayerSymbols::O
  end

  it "prints winning status of the game" do
    winning_board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, nil, PlayerSymbols::O, PlayerSymbols::O, nil, nil, nil])

    expect(web_game.print_game_status(winning_board)).to eq "The game has been won by X"
  end

  it "prints draw status of the game" do
    drawn_board = Board.new([PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::O])
    expect(web_game.print_game_status(drawn_board)).to eq "The game is a draw!"
  end
end
