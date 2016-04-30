class Player
  attr_accessor :hand, :chips, :current_bet, :name, :computer

  def initialize(name)
    @hand = []
    @chips = 10000
    @name = name
    @current_bet = 0
  end

  def get_hand
      hand
  end

  def get_chips(amount)
    @chips = chips.to_s.to_i - amount
    @current_bet = current_bet.to_s.to_i + amount
    amount
  end
end
