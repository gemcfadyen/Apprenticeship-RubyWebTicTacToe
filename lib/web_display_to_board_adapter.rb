require 'board'
require 'player_symbols'

class WebDisplayToBoardAdapter

  def translate(web_representation_of_board)
    grid = web_representation_of_board.delete(":").delete("[").delete("]").delete(" ").split(",").map do |cell_value|

      cell_value.to_s == "nil" || is_number(cell_value) ? nil : PlayerSymbols::to_symbol(cell_value.to_s)
    end
    puts "Grid is " + grid.to_s
    Board.new(grid)
  end

  def is_number(value)
    Integer(value)
    true
  rescue ArgumentError
    false
  end
end
