require 'ai_player'
require 'board'

RSpec.describe AiPlayer do
  let(:ai_player) { AiPlayer.new(PlayerSymbols::X) }

  it "has a player symbol" do
    expect(ai_player.game_symbol).to eq(PlayerSymbols::X)
  end

  it "scores zero when a draw is made" do
    draw_board = Board.new([PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::X])
    expect(ai_player.minimax(draw_board, true, draw_board.vacant_indices.size, -2, 2).first.first).to be (0 + draw_board.vacant_indices.size)
  end

  it "scores one if computer wins" do
    winning_board = Board.new([PlayerSymbols::X, PlayerSymbols::X, PlayerSymbols::X, nil, nil, PlayerSymbols::O, PlayerSymbols::O, nil, nil])

    expect(ai_player.minimax(winning_board, true, winning_board.vacant_indices.size, -2, 2).first.first).to be(1 + winning_board.vacant_indices.size)
  end

  it "scores negative one if opponent wins" do
    winning_board = Board.new([PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::O, nil, nil, PlayerSymbols::X, PlayerSymbols::X, nil, nil])

    expect(ai_player.minimax(winning_board, true, winning_board.vacant_indices.size, -2, 2).first.first).to be(-1 - winning_board.vacant_indices.size)
  end

  it "takes a winning move on top row" do
    winning_move_on_top_row = Board.new([PlayerSymbols::X, nil, PlayerSymbols::X, nil, nil, PlayerSymbols::O, PlayerSymbols::O, nil, nil])

    move = ai_player.choose_move(winning_move_on_top_row)
    expect(move).to eq(1)
  end

  it "takes a winning move on middle row" do
    winning_move_on_middle_row = Board.new([PlayerSymbols::O, nil, nil, PlayerSymbols::X, nil, PlayerSymbols::X, PlayerSymbols::O, nil, PlayerSymbols::O])

    move = ai_player.choose_move(winning_move_on_middle_row)
    expect(move).to eq(4)
  end

  it "takes a winning move on bottom row" do
    winning_move_on_bottom_row = Board.new([PlayerSymbols::O, nil, PlayerSymbols::O, PlayerSymbols::O, nil, PlayerSymbols::X, nil, PlayerSymbols::X, PlayerSymbols::X])

    move = ai_player.choose_move(winning_move_on_bottom_row)
    expect(move).to eq(6)
  end

  it "takes a winning move on left column" do
    winning_move_on_left_column = Board.new([PlayerSymbols::X, PlayerSymbols::O, nil, nil, nil, nil,  PlayerSymbols::X, nil, PlayerSymbols::O])

    move = ai_player.choose_move(winning_move_on_left_column)
    expect(move).to eq(3)
  end

  it "takes a winning move on middle column" do
    winning_move_on_middle_column = Board.new([nil, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, PlayerSymbols::X, nil, nil, nil, nil])

    move = ai_player.choose_move(winning_move_on_middle_column)
    expect(move).to eq(7)
  end

  it "takes a winning move on right column" do
    winning_move_on_right_column = Board.new([nil, PlayerSymbols::O, PlayerSymbols::X, nil, PlayerSymbols::O, nil, nil, nil, PlayerSymbols::X])

    move = ai_player.choose_move(winning_move_on_right_column)
    expect(move).to eq(5)
  end

  it "takes a winning move on first diagonal" do
    winning_move_on_first_diagonal = Board.new([PlayerSymbols::X, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::X])

    move = ai_player.choose_move(winning_move_on_first_diagonal)
    expect(move).to eq(4)
  end

  it "takes a winning move on second diagonal" do
    winning_move_on_second_diagonal = Board.new([PlayerSymbols::O, nil, nil, nil, PlayerSymbols::X, nil, PlayerSymbols::X, PlayerSymbols::O, nil])

    move = ai_player.choose_move(winning_move_on_second_diagonal)
    expect(move).to eq(2)
  end

  it "takes a blocking move on top row" do
    blocking_move_on_top_row = Board.new([PlayerSymbols::O, nil, PlayerSymbols::O, PlayerSymbols::X, nil, nil, nil, nil, PlayerSymbols::X])

    move = ai_player.choose_move(blocking_move_on_top_row)
    expect(move).to eq(1)
  end

  it "takes a blocking move on middle row" do
    blocking_move_on_middle_row = Board.new([PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::O, nil, nil, PlayerSymbols::X, nil])

    move = ai_player.choose_move(blocking_move_on_middle_row)
    expect(move).to eq(5)
  end

  it "takes a blocking move on bottom row" do
    blocking_move_on_bottom_row = Board.new([PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, nil, nil, PlayerSymbols::X, nil, PlayerSymbols::O, PlayerSymbols::O])

    move = ai_player.choose_move(blocking_move_on_bottom_row)
    expect(move).to eq(6)
  end

  it "takes a blocking move on left column" do
    blocking_move_on_left_column = Board.new([PlayerSymbols::O, nil, nil, nil, nil, PlayerSymbols::X, PlayerSymbols::O, PlayerSymbols::X, nil])

    move = ai_player.choose_move(blocking_move_on_left_column)
    expect(move).to eq(3)
  end

  it "takes a blocking move on middle column" do
    blocking_move_on_middle_column = Board.new([nil, PlayerSymbols::O, nil, PlayerSymbols::X,nil, nil, nil, PlayerSymbols::O, nil])

    move = ai_player.choose_move(blocking_move_on_middle_column)
    expect(move).to eq(4)
  end

  it "takes a blocking move on right column" do
    blocking_move_on_right_column = Board.new([nil, nil, PlayerSymbols::O, nil, nil, PlayerSymbols::O, nil, PlayerSymbols::X, nil])

    move = ai_player.choose_move(blocking_move_on_right_column)
    expect(move).to eq(8)
  end

 it "takes a blocking move on first diagonal" do
    blocking_move_on_first_diagonal = Board.new([PlayerSymbols::O, PlayerSymbols::X, nil, nil,nil, nil, nil, nil, PlayerSymbols::O])

    move = ai_player.choose_move(blocking_move_on_first_diagonal)
    expect(move).to eq(4)
  end

 it "takes a blocking move on second diagonal" do
    blocking_move_on_second_diagonal = Board.new([nil, nil, PlayerSymbols::O, nil, nil, nil, PlayerSymbols::O, PlayerSymbols::X, nil])

    move = ai_player.choose_move(blocking_move_on_second_diagonal)
    expect(move).to eq(4)
  end
end
