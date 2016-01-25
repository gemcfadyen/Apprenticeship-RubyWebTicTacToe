require 'player'

class HumanPlayer
  include Player

  def initialize(command_line_interface, symbol)
    @command_line_interface = command_line_interface
    super(symbol)
  end

  def choose_move(board)
    command_line_interface.get_move_from_player(board)
  end

  private

  attr_reader :command_line_interface
end
