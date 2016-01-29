require 'board'
require 'player_symbols'
require 'prepare_players_for_game'
require 'web_display_to_board_adapter'

class WebTicTacToe

  def initialize(player_factory)
    @player_factory = player_factory
  end

  def play(move, board)
    game = Game.new(board, PreparePlayersForGame.new.prepare(player_factory.create_players(PlayerOptions::HUMAN_VS_HUMAN, nil), board, move))
    game.play
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
  attr_reader :player_factory
end

