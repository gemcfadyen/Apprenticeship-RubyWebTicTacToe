require 'player_symbols'

class PreparePlayersForGame
  def prepare(players, board, next_move)
    next_player_symbol = next_players_symbol(board)
    sorted_players = sort(players, next_player_symbol)
    sorted_players.first.set_move(next_move)
    sorted_players
  end

  private

  def next_players_symbol(board)
    number_of_x = board.grid_for_display.flatten.count(PlayerSymbols::X)
    number_of_o = board.grid_for_display.flatten.count(PlayerSymbols::O)
    next_players_symbol = number_of_x > number_of_o ? PlayerSymbols::O : PlayerSymbols::X
  end

  def sort(players, symbol)
    (players[0].game_symbol == symbol) ? players : players.reverse
  end
end
