require 'game'
require 'game_state'
require 'player_configurer'
require 'player_options'
require 'player_symbols'
require 'web_board_factory'

class WebTicTacToe
  GRID = 'grid'
  MOVE = 'move-taken'

  def initialize(board_factory, grid_formatter, player_configurer)
    @board_factory = board_factory
    @grid_formatter = grid_formatter
    @player_configurer = player_configurer
  end

  def play_ttt_using(params)
    board = board_factory.create_board(params[GRID])
    selected_move = params[MOVE]
    updated_board = selected_move.nil? ? board : play(selected_move.to_i - 1, board)
    GameState.new(grid_formatter.format(updated_board), PlayerSymbols::all, print_game_status(updated_board))
  end

  def play(move, board)
    game = Game.new(board, player_configurer.for(PlayerOptions::HUMAN_VS_HUMAN, board, move))
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
  attr_reader :board_factory, :grid_formatter, :player_configurer
end
