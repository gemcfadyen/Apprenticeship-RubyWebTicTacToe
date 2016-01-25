require 'player_symbols'
require 'human_player'
require 'player_options'
require 'ai_player'

class PlayerFactory
  def create_players(player_option, command_line_ui)
    if player_option == PlayerOptions::HUMAN_VS_HUMAN
      human_vs_human(command_line_ui)
    elsif player_option == PlayerOptions::HUMAN_VS_AI
      human_vs_ai(command_line_ui)
    else
      ai_vs_human(command_line_ui)
    end
  end

  private

  def human_vs_human(command_line_ui)
    [
      HumanPlayer.new(command_line_ui, PlayerSymbols::X),
      HumanPlayer.new(command_line_ui, PlayerSymbols::O)
    ]
  end

  def human_vs_ai(command_line_ui)
    [
      HumanPlayer.new(command_line_ui, PlayerSymbols::X),
      AiPlayer.new(PlayerSymbols::O)
    ]
  end

  def ai_vs_human(command_line_ui)
    [
      AiPlayer.new(PlayerSymbols::X),
      HumanPlayer.new(command_line_ui, PlayerSymbols::O)
    ]
  end
end
