require 'prepare_players_for_game'
require 'web_human_player'
require 'web_player_factory'
require 'player_symbols'
require 'board'

RSpec.describe PreparePlayersForGame do
  it "preserves the order of the players when board is empty" do
    player_one = WebHumanPlayer.new(PlayerSymbols::X)
    player_two = WebHumanPlayer.new(PlayerSymbols::O)

    sorted_players = PreparePlayersForGame.new.prepare([player_one, player_two], Board.new, 1)

    expect(sorted_players.first).to be player_one
  end

  it "when player X has taken a turn, the first player should be player O" do
    player_one = WebHumanPlayer.new(PlayerSymbols::X)
    player_two = WebHumanPlayer.new(PlayerSymbols::O)
    board = Board.new([PlayerSymbols::X, nil, nil, nil, nil, nil, nil, nil, nil])

    sorted_players = PreparePlayersForGame.new.prepare([player_one, player_two], board, 1)

    expect(sorted_players.first).to be player_two
  end

  it "when many turns have been taken, the first player is correctly determined" do
    player_one = WebHumanPlayer.new(PlayerSymbols::X)
    player_two = WebHumanPlayer.new(PlayerSymbols::O)
    board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, nil, nil, nil, nil])

    sorted_players = PreparePlayersForGame.new.prepare([player_one, player_two], board, 1)

    expect(sorted_players.first).to be player_two
  end

  it "preloads first player with move" do
    player_one = WebHumanPlayer.new(PlayerSymbols::X)
    player_two = WebHumanPlayer.new(PlayerSymbols::O)
    board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, nil, nil, nil, nil])

    loaded_players = PreparePlayersForGame.new.prepare([player_one, player_two], board, 3)

    expect(player_two.choose_move(board)).to eq 3
  end
end
