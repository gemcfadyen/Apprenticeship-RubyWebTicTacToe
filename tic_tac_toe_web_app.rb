require 'sinatra'
require 'sinatra/base'

$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'board'
require 'player_symbols'
require 'empty_cells_to_one_indexed_board_converter'
require 'web_display_to_board_adapter'
require 'web_game'

get '/' do
  @formatted_rows = EmptyCellsToOneIndexedBoardConverter::new.format(Board.new)
  @valid_moves = PlayerSymbols::all
  erb :landing_page
end

get '/next_move' do
  @move = params['move-taken']
  p "*** User selected #{@move}"

  contents_of_board = params['grid']
  p "*** grid to update is " + contents_of_board.to_s

  p "contents of board is: " +  contents_of_board.to_s
  adapter = WebDisplayToBoardAdapter.new
  board = adapter.translate(contents_of_board)
  p "board returned from adapter is " + board.grid_for_display.to_s

  #######

  web_game = WebGame.new
  new_board =  web_game.make_move(board, @move.to_i - 1)
  p "After move has been placed the new board: " + new_board.grid_for_display.to_s

  @formatted_rows = EmptyCellsToOneIndexedBoardConverter::new.format(new_board)
  @valid_moves = [PlayerSymbols::X.to_s, PlayerSymbols::O.to_s]
  @game_status = web_game.print_game_status(new_board) 
  erb :landing_page
end

def is_number(value)
  Integer(value)
  return true

rescue
  return false
end
