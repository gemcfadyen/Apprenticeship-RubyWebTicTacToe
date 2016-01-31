require 'player_symbols'

class PlayerPreparer

  def initialize(player_factory)
    @player_factory = player_factory
  end

  def for(game_type, board, next_move)
    players = player_factory.create_players(game_type, unused_prompt)
    sorted_players = sort(players, next_players_symbol(board))
    sorted_players.first.set_move(next_move)
    # here i can have a move loader class 'factory' that does the pre-load move, so pass in another dependency to do this. it can take the game type and the first player and load if it is a human type
    # maybe the sorting can also be in a separate class.  then this class just coordinates them all
    sorted_players
  end

  private

  attr_reader :player_factory

  def unused_prompt
    nil
  end

  def next_players_symbol(board)
    number_of_x = board.grid_for_display.flatten.count(PlayerSymbols::X)
    number_of_o = board.grid_for_display.flatten.count(PlayerSymbols::O)
    next_players_symbol = number_of_x > number_of_o ? PlayerSymbols::O : PlayerSymbols::X
  end

  def sort(players, symbol)
    (players[0].game_symbol == symbol) ? players : players.reverse
  end
end
