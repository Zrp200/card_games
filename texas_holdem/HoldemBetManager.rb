require_relative '../BetManager.rb'

class HoldemBetManager < BetManager

  def bet(players)
    manage_betting_order(players)
  end
end
