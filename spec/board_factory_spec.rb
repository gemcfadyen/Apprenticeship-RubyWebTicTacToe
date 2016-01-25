require 'board_factory'

RSpec.describe BoardFactory do
  let(:board_factory) { BoardFactory.new }

  it "creates 3x3 board " do
    board = board_factory.create_board
    expect(board.grid_for_display.size).to be 3
  end
end
