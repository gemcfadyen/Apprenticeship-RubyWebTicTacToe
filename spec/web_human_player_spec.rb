require 'web_human_player'
require 'player_symbols'
require 'board'

RSpec.describe WebHumanPlayer do
  let(:player) { WebHumanPlayer.new(PlayerSymbols::X) }

  it "preloads the player with the next move" do
    player.set_move(3)

    expect(player.choose_move(Board.new)).to eq 3
  end

  it "is in a ready state when a position is preloaded" do
    player.set_move(3)

    expect(player.ready?).to be true
  end

  it "is not ready when no position pre loaded" do
    expect(player.ready?).to be false
  end

  it "taking a move resets the ready flag" do
    player.set_move(3)

    player.choose_move(Board.new)

    expect(player.ready?).to be false
  end
end
