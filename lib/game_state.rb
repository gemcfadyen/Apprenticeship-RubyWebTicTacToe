class GameState

  def initialize(formatted_rows, valid_moves, status)
    @formatted_rows = formatted_rows
    @valid_moves = valid_moves
    @status = status
  end

  def valid_moves_includes?(symbol)
    valid_moves.include?(symbol)
  end

 def status?
   !status.nil?
 end

 def flatten_rows
   formatted_rows.flatten
 end
  attr_reader :formatted_rows, :valid_moves, :status
end
