
class Player
  attr_accessor :hand, :chips, :current_bet, :name, :computer

  def initialize(name)
    @hand = []
    @chips = 10000
    @name = name
    @current_bet = 0
    #@folded = false
    #@computer = computer?
  end

  def get_hand
    #if computer?
      #if folded
      #  "Folded"
      #else
      #  "Playing"
      #end
    #else  
      hand
    #end
  end

  def get_chips(amount)
    @chips = chips.to_s.to_i - amount
    @current_bet = current_bet.to_s.to_i + amount
    amount
  end
end
