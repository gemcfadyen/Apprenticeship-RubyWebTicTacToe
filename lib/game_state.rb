class GameState

  def initialize(formatted_rows, valid_moves, status)
    @formatted_rows = formatted_rows
    @valid_moves = valid_moves
    @status = status
  end

  attr_reader :formatted_rows, :valid_moves, :status
end
