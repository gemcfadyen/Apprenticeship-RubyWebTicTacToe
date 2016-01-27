ENV['RACK_ENV'] = 'test'

require 'tic_tac_toe_web_app'
require 'rack/test'
require 'erb'

RSpec.describe TicTacToeWebApp do
  include Rack::Test::Methods

  def app
    TicTacToeWebApp
    #  Sinatra::Application
  end

  it "can successfully load landing page" do
    get '/'
    expect(last_response).to be_ok
  end

  it "can successfully make a move request" do
    get '/next_move?move-taken=3&grid=[1, 2, 3, 4, 5, 6, 7, 8, 9]'
    expect(last_response).to be_ok
  end
end
