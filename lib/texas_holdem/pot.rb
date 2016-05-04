class Pot
  attr_accessor :pot, :total_bet
  attr_reader :max_bet, :min_bet

  def initialize
    @pot = 0
    @min_bet = 50
    @max_bet = 500
    @big_blind = 50
    @small_blind =	25
    @total_bet = 0
  end

  def bet(players)
    manage_betting_order(players)
  end

  #the player is only getting what the other person bet, not its money back
  #if a player bets at end and another player folds, the original player does not
  #get its money back
  def award_pot(player)
    pot_value = pot
    player.chips += pot
    @pot = 0
    pot_value
  end

  def add_to_pot(bet)
    @pot = pot + bet
  end

  def reset_bets(players)
    players.each do |player|
      player.current_bet = 0
    end
    @total_bet = 0
  end
end