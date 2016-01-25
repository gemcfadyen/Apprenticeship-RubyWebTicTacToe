require 'game'
require 'board'
require 'human_player'
require 'player_symbols'

RSpec.describe Game do
  let(:player_x_spy) { instance_double(HumanPlayer).as_null_object }
  let(:player_o_spy) { instance_double(HumanPlayer).as_null_object }

  it "players take turn until there is no space on board" do
    expect(player_x_spy).to receive(:choose_move).exactly(5).times.and_return(0, 1, 4, 5, 6)
    expect(player_o_spy).to receive(:choose_move).exactly(4).times.and_return(2, 3, 7, 8)

    Game.new(Board.new, [player_x_spy, player_o_spy]).play
  end

  it "game ends when a winning combination is formed" do
    allow(player_x_spy).to receive(:choose_move).once.and_return(2)
    allow(player_x_spy).to receive(:game_symbol).and_return(PlayerSymbols::X)

    board = Board.new([PlayerSymbols::X, PlayerSymbols::X, nil, PlayerSymbols::O, nil, nil, nil, nil, nil])
    updated_board = Game.new(board, [player_x_spy, player_o_spy]).play

    expect(updated_board.get_symbol_at(2)).to be (PlayerSymbols::X)
    expect(player_o_spy).to_not have_received(:choose_move)
  end


  it "game ends when there are no free spaces on the board" do
    full_board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X])
    game = Game.new(full_board, [player_x_spy, player_o_spy]).play

    expect(player_o_spy).to_not have_received(:choose_move)
    expect(player_x_spy).to_not have_received(:choose_move)
  end
end
