require 'move_loader'
require 'player_symbols'
require 'board'
require 'player'

RSpec.describe MoveLoader do

  it "pre loads a human player with a move" do
    player = WebHumanPlayer.new(PlayerSymbols::X)

    MoveLoader.new.preload(player, 3)

    expect(player.choose_move(Board.new)).to be 3
  end

  it "does not preload a non human player with given move" do
    player = FakePlayer.new(PlayerSymbols::X)

    MoveLoader.new.preload(player, 3)

    expect(player.choose_move(Board.new)).to_not be 3
  end

  it "web human not ready if move is nil" do
    player = WebHumanPlayer.new(PlayerSymbols::X)

    MoveLoader.new.preload(player, nil)

    expect(player.ready?).to be false
  end
end

class FakePlayer
  include Player

  def choose_move(board)
    100
  end
end
