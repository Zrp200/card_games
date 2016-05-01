require_relative './deck.rb'
require_relative './player.rb'

class TexasHoldemDealer
  def initialize(bet_manager, hand_evaluator, players)
    @table = Player.new 'Table'
    @bet_manager = bet_manager
    @currently_in_game = players
    @hand_evaluator = hand_evaluator
  end

  def play_game
    @deck = Deck.new
  end

  def hole_cards
    @deck.deal 2, *@currently_in_game
    display_cards
    bet
  end

  def the_flop
    @deck.deal 3, @table
    display_cards
    bet
  end

  def the_turn
    @deck.deal 1, @table
    display_cards
    bet
  end

  def the_river
    @deck.deal 1, @table
    display_cards
    bet
    determine_winner
  end

  private

  def display_cards
    @currently_in_game.each { |player| puts player }
    puts @table
    puts '------------'
    puts '------------'
  end

  def bet
    players_who_bet = @bet_manager.bet(@currently_in_game)
    #Make sure betting order doesn't get messed up here
    @currently_in_game = players_who_bet
  end

  def determine_winner
    hand_value, winning_hand = @hand_evaluator.get_hand_value(@table.hand.sorted_cards)
    winning_player = @table
    #change this to only examine players currently in the game
    @currently_in_game.each do |player|
      value, hand = @hand_evaluator.evaluate_hands(player.hand.cards, @table.hand.cards)
      hand_value, winning_hand, winning_player = value, hand, player if value > hand_value
    end
    puts "#{winning_player.name} wins #{award_pot(winning_player)} with #{get_hand_name(hand_value)}."
  end

  def get_hand_name(hand_value)
    @hand_evaluator.get_hand_name(hand_value)
  end

  def award_pot(player)
    @bet_manager.award_pot(player)
  end
end
