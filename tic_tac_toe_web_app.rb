require 'sinatra'
require 'sinatra/base'

$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'board'
require 'player_symbols'

get '/' do
  board = Board.new

  rows = board.grid_for_display
  dimension = 3 
  #transform rows to numbers
  @formatted_rows = rows.map.with_index do |row, o|
    p "index of outer rows is: " + o.to_s
    offset = dimension * o
    p "offset is : "  + offset.to_s
    formatted_cells =  row.map.with_index do  |cell, i| 
      cell.nil? ? i+1 + offset : cell.to_s
    end
  end

  p "for displaying " +  @formatted_rows.to_s
  @valid_moves = [PlayerSymbols::X, PlayerSymbols::O]
  erb :landing_page
end

get '/next_move' do

  p "*** User has taken a turn, - update the board and display new grid"

  @move = params['move-taken']
  p "*** User selected #{@move}"

  contents_of_board = params['grid']
  p "*** grid to update is " + contents_of_board.to_s

  # create a new board from this, update it
  #
  grid = contents_of_board.delete("[").delete("]").delete(" ").split(",").map do |n|
    if is_number(n)
      nil 
    else
     n
    end

    end

    board =  Board.new(grid)
    new_board = board.make_move(@move.to_i - 1, PlayerSymbols::X)
    p "Updated board is : " + new_board.grid_for_display.to_s
    dimension = 3
    @formatted_rows = new_board.grid_for_display.map.with_index do |row, o|
      p "index of outer rows is: " + o.to_s
      offset = dimension * o
      p "offset is : "  + offset.to_s
      formatted_cells =  row.map.with_index do  |cell, i| 
        cell.nil? ? i+1 + offset : cell.to_s
      end
    end

    p "for displaying " +  @formatted_rows.to_s
    @valid_moves = [PlayerSymbols::X.to_s, PlayerSymbols::O.to_s]

    if @move == "1" 
      @game_status = "Winner!" 
      erb :landing_page
    else 
      erb :landing_page
    end
  end

  def is_number(value)
    Integer(value)
    return true

  rescue
    return false
  end
