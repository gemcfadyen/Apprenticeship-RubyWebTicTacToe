require 'web_display_to_board_adapter'

RSpec.describe WebDisplayToBoardAdapter do
  let(:adapter) { WebDisplayToBoardAdapter.new }

  it "converts grid representation to a board" do
    grid_representation = "[1, 2, 3, 4, 5, 6, 7, 8, 9]"
    expect(adapter.translate(grid_representation).grid_for_display).to eq [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end

  it "converts grid representation with symbols into a board" do
    grid_representation = "[X, 2, 3, O, 5, 6, 7, 8, 9]"
    expect(adapter.translate(grid_representation).grid_for_display).to eq [[PlayerSymbols::X, nil, nil], [PlayerSymbols::O, nil, nil], [nil, nil, nil]]

  end

  it "converts empty grid representation into an empty board" do
    grid_representation = "[nil, nil, nil, nil, nil, nil, nil, nil, nil]"
    expect(adapter.translate(grid_representation).grid_for_display).to eq [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end
end
