require 'web_human_player'
require 'player_factory'

class WebPlayerFactory < PlayerFactory
  def create_human(unused_command_line_ui, symbol)
    WebHumanPlayer.new(symbol)
  end
end
