require_relative '../bet_manager.rb'

class HoldemBetManager < BetManager
  def bet(players)
    manage_betting_order(players)
  end
end
