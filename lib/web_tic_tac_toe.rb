require 'game'
require 'game_state'
require 'player_options'
require 'player_symbols'
require 'web_board_factory'

class WebTicTacToe
  GRID = 'grid'
  MOVE = 'move-taken'
  PLAYER_OPTION = 'player_type'

  def initialize(board_factory, grid_formatter, player_preparer)
    @board_factory = board_factory
    @grid_formatter = grid_formatter
    @player_preparer = player_preparer
  end

  def play_ttt_using(params)
    updated_board = play(current_board(params), ordered_players(params))
    game_state_based_on(updated_board)
  end

  def play(board, players)
    game = Game.new(board, players)
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

  attr_reader :board_factory, :grid_formatter, :player_preparer

  def current_board(params)
    board_factory.create_board(params[GRID])
  end

  def ordered_players(params)
    player_preparer.for(selected_player_option(params), current_board(params), selected_move(params))
  end

  def selected_player_option(params)
    PlayerOptions::get_player_type_for_id(selected_player_type(params).to_i)
  end

  def selected_move(params)
    params[MOVE]
  end

  def selected_player_type(params)
    params[PLAYER_OPTION]
  end

  def game_state_based_on(updated_board)
    GameState.new(grid_formatter.format(updated_board), PlayerSymbols::all, print_game_status(updated_board))
  end
end
