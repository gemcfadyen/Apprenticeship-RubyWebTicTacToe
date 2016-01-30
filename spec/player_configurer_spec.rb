require 'player_configurer'
require 'web_human_player'
require 'web_player_factory'
require 'player_symbols'
require 'board'

RSpec.describe PlayerConfigurer do
  let (:player_factory) { instance_double(WebPlayerFactory) }
  let (:player_configurer) { PlayerConfigurer.new(player_factory) }
  let (:player_one) { WebHumanPlayer.new(PlayerSymbols::X) }
  let (:player_two) { WebHumanPlayer.new(PlayerSymbols::O) }

  it "preserves the order of the players when board is empty" do
    allow(player_factory).to receive(:create_players).and_return([player_one, player_two])

    sorted_players = player_configurer.for(PlayerOptions::HUMAN_VS_HUMAN, Board.new, 1)

    expect(sorted_players.first).to be player_one
  end

  it "when player X has taken a turn, the first player should be player O" do
    allow(player_factory).to receive(:create_players).and_return([player_one, player_two])
    board = Board.new([PlayerSymbols::X, nil, nil, nil, nil, nil, nil, nil, nil])

    sorted_players = player_configurer.for(PlayerOptions::HUMAN_VS_HUMAN, board, 1)

    expect(sorted_players.first.game_symbol).to be player_two.game_symbol
  end

  it "when many turns have been taken, the first player is correctly determined" do
    allow(player_factory).to receive(:create_players).and_return([player_one, player_two])
    board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, nil, nil, nil, nil])

    sorted_players = player_configurer.for(PlayerOptions::HUMAN_VS_HUMAN, board, 1)

    expect(sorted_players.first.game_symbol).to be player_two.game_symbol
  end

  it "preloads first player with move" do
    allow(player_factory).to receive(:create_players).and_return([player_one, player_two])
    board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, nil, nil, nil, nil])

    loaded_players = player_configurer.for(PlayerOptions::HUMAN_VS_HUMAN, board, 3)

    expect(loaded_players.first.choose_move(board)).to eq 3
  end
end
