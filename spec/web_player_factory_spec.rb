require 'web_player_factory'
require 'player_options'

RSpec.describe WebPlayerFactory do
  it "creates two web players" do
    players = WebPlayerFactory.new.create_players(PlayerOptions::HUMAN_VS_HUMAN, nil)
    expect(players.first.class).to be WebHumanPlayer
  end
end

