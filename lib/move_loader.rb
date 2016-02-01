require 'web_human_player'

class MoveLoader
  def preload(player, move)
    if web_human?(player) && valid_move?(move)
      player.set_move(move.to_i)
    end
  end

  private

  def web_human?(player)
    player.class == WebHumanPlayer
  end

  def valid_move?(move)
    !move.nil?
  end
end
