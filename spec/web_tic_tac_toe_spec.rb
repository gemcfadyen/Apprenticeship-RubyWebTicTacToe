require 'web_tic_tac_toe'
require 'web_player_factory'
require 'web_board_factory'
require 'board'
require 'web_human_player'
require 'player_preparer'
require 'grid_formatter'
require 'web_display_to_board_adapter'

RSpec.describe WebTicTacToe do
  let(:player_preparer) { instance_double(PlayerPreparer) }
  let(:web_game) { WebTicTacToe.new(WebBoardFactory.new(WebDisplayToBoardAdapter.new), GridFormatter.new, player_preparer) }

  it "move taken by human player at given position" do
    position = 8
    expect(player_preparer).to receive(:for).with(PlayerOptions::HUMAN_VS_HUMAN, an_instance_of(Board), 8).and_return(prepare_players_for_move(position))
    web_parameters = { WebTicTacToe::MOVE => position,  WebTicTacToe::GRID => "[:X, :O, 2, :X, :O, 5, 6, 7, 8]"}

    game_state = web_game.play_ttt_using(web_parameters)

    expect(game_state.formatted_rows).to eq [[:X, :O, 2], [:X, :O, 5], [6, 7, :X]]
    expect(game_state.valid_moves).to eq PlayerSymbols::all
    expect(game_state.status).to eq nil
  end

  it "starts with no moves" do
    web_parameters = {}

    game_state = web_game.play_ttt_using(web_parameters)

    expect(game_state.formatted_rows).to eq [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    expect(game_state.valid_moves).to eq PlayerSymbols::all
    expect(game_state.status).to eq nil
  end

  it "starts game and takes first move" do
   position = 1
    allow(player_preparer).to receive(:for).and_return(prepare_players_for_move(position))

    updated_board = web_game.play(position, Board.new)

    expect(updated_board.get_symbol_at(position)).to eq PlayerSymbols::X
  end

  it "prints winning status of the game" do
    winning_board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, nil, PlayerSymbols::O, PlayerSymbols::O, nil, nil, nil])

    expect(web_game.print_game_status(winning_board)).to eq "The game has been won by X"
  end

  it "prints draw status of the game" do
    drawn_board = Board.new([PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::O])
    expect(web_game.print_game_status(drawn_board)).to eq "The game is a draw!"
  end

  def prepare_players_for_move(position)
    player_one = WebHumanPlayer.new(PlayerSymbols::X)
    player_two = WebHumanPlayer.new(PlayerSymbols::O)
    player_one.set_move(position)

    [player_one, player_two]
  end
end
