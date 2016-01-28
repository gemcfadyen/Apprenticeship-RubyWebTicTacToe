require 'web_player'
require 'player_symbols'
require 'board'

RSpec.describe WebPlayer do
  it "preloads the player with the next move" do
    player = WebPlayer.new(PlayerSymbols::X)
    player.set_move(3)

    expect(player.choose_move(Board.new)).to eq 3
  end

end
