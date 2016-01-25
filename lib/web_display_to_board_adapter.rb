require 'board'
require 'player_symbols'

class WebDisplayToBoardAdapter

  def translate(web_representation_of_board)
    grid = strip_to_grid_contents(web_representation_of_board).map do |cell_value|
      to_nil?(cell_value) ? nil : PlayerSymbols::to_symbol(cell_value)
    end

    Board.new(grid)
  end

  private

  def strip_to_grid_contents(grid_representation)
    grid_representation.delete(":").delete("[").delete("]").delete(" ").split(",")
  end

  def to_nil?(cell_value)
    cell_value == "nil" || is_number(cell_value)
  end

  def is_number(value)
    Integer(value)
    true
  rescue ArgumentError
    false
  end
end
