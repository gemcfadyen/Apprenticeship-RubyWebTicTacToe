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
    chosen_move = position
    @position = nil
    chosen_move
  end

  def is_ready?
    position.nil? ? false : true
  end

  private

  attr_reader :position, :is_ready
end
