require 'web_tic_tac_toe'
require 'web_player_factory'
require 'board'
require 'web_human_player'

RSpec.describe WebTicTacToe do

  let(:web_game) { WebTicTacToe.new(WebPlayerFactory.new) }

  it "starts game and takes first move" do
    updated_board = web_game.play(1, Board.new)

    expect(updated_board.get_symbol_at(1)).to eq PlayerSymbols::X
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
