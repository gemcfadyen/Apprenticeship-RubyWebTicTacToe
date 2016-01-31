require 'sinatra/base'
require 'web_board_factory'
require 'grid_formatter'
require 'web_display_to_board_adapter'
require 'web_player_factory'
require 'player_preparer'
require 'web_tic_tac_toe'

class WebTTTController < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  set :public_folder, File.dirname(__FILE__) + '/../public'

  get '/' do
    erb :player_options
  end

  get '/player_options' do
    @game_state = WebTicTacToe.new(WebBoardFactory.new(WebDisplayToBoardAdapter.new), GridFormatter.new, PlayerPreparer.new(WebPlayerFactory.new)).play_ttt_using(params)
    erb :game
  end

  get '/next_move' do
    @game_state = WebTicTacToe.new(WebBoardFactory.new(WebDisplayToBoardAdapter.new), GridFormatter.new, PlayerPreparer.new(WebPlayerFactory.new)).play_ttt_using(params)

    erb :game
  end
end
