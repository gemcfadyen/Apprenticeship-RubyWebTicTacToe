require 'player'

class WebPlayer
  include Player

  def initialize(symbol)
    super(symbol)
  end

  def set_move(position)
    @position = position
  end

  def choose_move(board)
    position
  end

  private

  attr_reader :position
end
