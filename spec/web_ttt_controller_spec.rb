ENV['RACK_ENV'] = 'test'

require 'web_ttt_controller'
require 'rack/test'
require 'erb'

RSpec.describe WebTTTController do
  include Rack::Test::Methods

  def app
    WebTTTController
  end

  it "can successfully select player option" do
    post '/player_options'
    expect(last_response).to be_ok
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
