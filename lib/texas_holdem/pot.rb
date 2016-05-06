require_relative 'bet_manager'
class Pot
  attr_accessor :pot, :total_bet
  attr_reader :max_bet, :min_bet

  def initialize
    super
    @big_blind = 50
    @small_blind = 25
  end

  def add_to_pot(bet)
    @pot += bet
  end

  def reset_bets(players)
    players.each { |player| player.current_bet = 0 }
    @total_bet = 0
  end
end