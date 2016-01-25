class Board

  def initialize(symbols = Array.new(9))
    @grid = symbols
  end

  def empty?
    grid.all?(&:nil?)
  end

  def make_move(index, symbol)
    copy_of_grid = grid.dup
    copy_of_grid[index] = symbol
    Board.new(copy_of_grid)
  end

  def free_spaces?
    grid.include?(nil)
  end

  def get_symbol_at(position)
    grid.at(position)
  end

  def winning_combination?
    not_nil_row(find_winning_row_from(all_rows))
  end

  def winning_symbol
    @winning_row = find_winning_row_from(all_rows)
    @winning_row.nil? ? nil : @winning_row.first
  end

  def vacant_indices
    grid.each_index.select{|v| grid[v].nil?}
  end

  def grid_for_display
    rows
  end

  private

  attr_reader :grid

  def find_winning_row_from(rows)
    @all_rows ||= rows.find do |row|
           all_cells_match = row.all? {|cell| cell == row.first}
           all_cells_match && not_nil_symbol(row.first)
        end
  end

  def not_nil_row(row)
    !row.nil?
  end

  def all_rows
    @all ||= rows + columns + diagonals
  end

  def not_nil_symbol(cell)
    !cell.nil?
  end

  def rows
    [
      [grid.at(0), grid.at(1), grid.at(2)],
      [grid.at(3), grid.at(4), grid.at(5)],
      [grid.at(6), grid.at(7), grid.at(8)]
    ]
  end

  def columns
    [
      [grid.at(0), grid.at(3), grid.at(6)],
      [grid.at(1), grid.at(4), grid.at(7)],
      [grid.at(2), grid.at(5), grid.at(8)]
    ]
  end

  def diagonals
    [
      [grid.at(0),grid.at(4), grid.at(8)],
      [grid.at(2), grid.at(4), grid.at(6)]
    ]
  end
end
