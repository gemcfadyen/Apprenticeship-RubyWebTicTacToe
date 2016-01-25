module Player

  def initialize(symbol)
    @symbol = symbol
  end

  def game_symbol
    symbol
  end

  private

  attr_reader :symbol

end

