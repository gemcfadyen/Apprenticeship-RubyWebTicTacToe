require 'sinatra/base'
require 'board_factory'
require 'board'
require 'player_symbols'
require 'grid_formatter'
require 'web_display_to_board_adapter'
require 'web_player_factory'
require 'prepare_players_for_game'
require 'game'
require 'web_tic_tac_toe'
require 'web_player_factory'

class WebTTTController < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  set :public_folder, File.dirname(__FILE__) + '/../public'

  get '/' do
    @formatted_rows = GridFormatter.new.format(BoardFactory.new.create_board)
    @valid_moves = PlayerSymbols::all
    erb :landing_page
  end

  get '/next_move' do
    @move = params['move-taken']
    contents_of_board = params['grid']
    # web_app.play_ttt_using(params)

    board = WebDisplayToBoardAdapter.new.translate(contents_of_board)
    web_app = WebTicTacToe.new(WebPlayerFactory.new)
    updated_board = web_app.play(@move.to_i - 1, board)

    @formatted_rows = GridFormatter::new.format(updated_board)
    @valid_moves = PlayerSymbols::all
    @game_status = web_app.print_game_status(updated_board)
    erb :landing_page
  end
end
