require 'player_symbols'

class PlayerPreparer

  def initialize(player_factory, move_loader)
    @player_factory = player_factory
    @move_loader = move_loader
  end

  def for(game_type, board, next_move)
    players = create_players_for(game_type)
    sorted_players = sort_order_of_players(players, next_players_symbol(board))
    preload_next_player_with_move(sorted_players.first, next_move)

    sorted_players
  end

  private

  attr_reader :player_factory, :move_loader

  def unused_prompt
    nil
  end

  def next_players_symbol(board)
    number_of_x = board.grid_for_display.flatten.count(PlayerSymbols::X)
    number_of_o = board.grid_for_display.flatten.count(PlayerSymbols::O)
    next_players_symbol = number_of_x > number_of_o ? PlayerSymbols::O : PlayerSymbols::X
  end

  def sort_order_of_players(players, symbol)
    players.first.game_symbol == symbol ? players : players.reverse
  end

  def create_players_for(type)
    player_factory.create_players(type, unused_prompt)
  end

  def preload_next_player_with_move(next_player, next_move)
    move_loader.preload(next_player, next_move)
  end
end
