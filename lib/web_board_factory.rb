require 'board_factory'

class WebBoardFactory < BoardFactory
  def initialize(board_adapter)
    @board_adapter = board_adapter
  end

  def create_board(grid_formation_from_web)
    if grid_formation_from_web.nil?
      return self.method(:create_board).super_method.call
    else
      return board_adapter.translate(grid_formation_from_web)
    end
  end

  private

  attr_reader :board_adapter
end


