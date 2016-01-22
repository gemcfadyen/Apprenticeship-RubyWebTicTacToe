require 'sinatra'
require 'sinatra/base'

get '/' do
  p "*** Landing Page - Empty grid displayed *****"
  erb :landing_page
end

get '/next_move' do
  p "*** User has taken a turn, - update the board and display new grid"

  @move = params['move-taken']
  p "*** User selected #{@move}"

  if @move == "1" 
    p "*** Game over***"
    erb :game_in_play
  end
end

