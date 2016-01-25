class Game

  def initialize(board, players)
    @board = board
    @players = players
  end

  def play
    while game_in_progress
      current_player = players.first
      @board = board.make_move(current_player.choose_move(board), current_player.game_symbol)
      players.reverse!
    end
    board
  end

  private

  attr_reader :board, :players

  def game_in_progress
    board.free_spaces? && !board.winning_combination?
  end
end
