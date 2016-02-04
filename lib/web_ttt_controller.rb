require 'grid_formatter'
require 'move_loader'
require 'player_preparer'
require 'sinatra/base'
require 'web_board_factory'
require 'web_display_to_board_adapter'
require 'web_player_factory'
require 'web_tic_tac_toe'

class WebTTTController < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  set :public_folder, File.dirname(__FILE__) + '/../public'
  set :css_dir, File.dirname(__FILE__) + '/../public/css'
  enable :sessions

  get '/' do
    @player_options = PlayerOptions::all

    erb :player_options
  end

  post '/player_options' do
    session[:player_type] = params['player_type']

    @game_state = WebTicTacToe.new(
      WebBoardFactory.new(WebDisplayToBoardAdapter.new),
      GridFormatter.new,
      PlayerPreparer.new(WebPlayerFactory.new, MoveLoader.new)
    ).play_ttt_using(params)

    erb :game
  end

  get '/next_move' do
    params['player_type'] = session['player_type']

    @game_state = WebTicTacToe.new(
      WebBoardFactory.new(WebDisplayToBoardAdapter.new),
      GridFormatter.new,
      PlayerPreparer.new(WebPlayerFactory.new, MoveLoader.new)
    ).play_ttt_using(params)

    erb :game
  end
end
