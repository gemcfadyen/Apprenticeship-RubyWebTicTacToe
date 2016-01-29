require 'player'

class WebHumanPlayer
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

  def ready?
    position.nil? ? false : true
  end

  private

  attr_reader :position, :is_ready
end
