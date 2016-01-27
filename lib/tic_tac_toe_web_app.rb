require 'sinatra/base'
require 'board'
require 'player_symbols'
require 'one_indexed_grid_formatter'
require 'web_display_to_board_adapter'
require 'web_game'

class TicTacToeWebApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  set :public_folder, File.dirname(__FILE__) + '/../public'

  get '/' do
    @formatted_rows = OneIndexedGridFormatter.new.format(Board.new)
    @valid_moves = PlayerSymbols::all
    erb :landing_page
  end

  get '/next_move' do
    @move = params['move-taken']

    contents_of_board = params['grid']
    adapter = WebDisplayToBoardAdapter.new
    board = adapter.translate(contents_of_board)

    web_game = WebGame.new
    updated_board = web_game.make_move(board, @move.to_i - 1)

    @formatted_rows = OneIndexedGridFormatter::new.format(updated_board)
    @valid_moves = [PlayerSymbols::X.to_s, PlayerSymbols::O.to_s]
    @game_status = web_game.print_game_status(updated_board)
    erb :landing_page
  end
end
