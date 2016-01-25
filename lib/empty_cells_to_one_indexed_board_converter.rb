require 'board'

class EmptyCellsToOneIndexedBoardConverter

  def format(board)
    rows = board.grid_for_display
    dimension = rows.length

    formatted_rows = rows.map.with_index do |row, row_number|
      offset = dimension * row_number
      formatted_cells =  row.map.with_index do  |cell, cell_index| 
        cell.nil? ? cell_index + 1 + offset : cell
      end
    end
  end
end
