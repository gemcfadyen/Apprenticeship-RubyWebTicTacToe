require 'board'
require 'player_symbols'

class WebGame

  def make_move(board, position)
    next_players_symbol = next_players_symbol(board)
    board.make_move(position, next_players_symbol)
  end

  def print_game_status(board)
    if board.winning_combination?
      return "The game has been won by #{board.winning_symbol}"
    end

    if !board.free_spaces?
      return "The game is a draw!"
    end
  end

  private

  def next_players_symbol(board)
    number_of_x = board.grid_for_display.flatten.count(PlayerSymbols::X)
    number_of_o = board.grid_for_display.flatten.count(PlayerSymbols::O)
    next_players_symbol = number_of_x > number_of_o ? PlayerSymbols::O : PlayerSymbols::X
  end
end

