class PlayerOptions
  HUMAN_VS_HUMAN = "Human vs Human"
  HUMAN_VS_AI = "Human vs Ai"
  AI_VS_HUMAN = "Ai vs Human"

  ID_TO_PLAYER_TYPE = {
    1 => HUMAN_VS_HUMAN,
    2 => HUMAN_VS_AI,
    3 => AI_VS_HUMAN
  }

  def self.valid_ids
    ID_TO_PLAYER_TYPE.keys
  end

  def self.get_player_type_for_id(id)
    game_value_of_player = ID_TO_PLAYER_TYPE.fetch(id)
  end

  def self.display_player_options
    player_options_for_display = ID_TO_PLAYER_TYPE.each_pair.map do |id, option|
      open_bracket + id.to_s + close_bracket + space + option
    end
    player_options_for_display.join(comma + space)
  end

  private

  def self.open_bracket
    "("
  end

  def self.close_bracket
    ")"
  end

  def self.space
    " "
  end

  def self.comma
    ","
  end
end
