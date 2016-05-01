require_relative './deck.rb'
require_relative './player.rb'

class TexasHoldemDealer
  def initialize(bet_manager, hand_evaluator, players)
    @deck = Deck.new
    @table = Player.new 'Table'
    @bet_manager = bet_manager
    @currently_in_game = players
    @hand_evaluator = hand_evaluator
  end

  def play_game
    hole_cards
    the_flop
    the_turn
    the_river
    puts '*******'
    determine_winner
  end

  private

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
  end

  def determine_winner
    winning_player = @table
    hand_value, winning_hand =
      @hand_evaluator.get_hand_value(@table.hand.sorted_cards)
    @currently_in_game.each do |player|
      value, hand = @hand_evaluator.evaluate_hands(player.hand.cards,
                                                   @table.hand.cards)
      if value > hand_value
        hand_value = value
        winning_hand = hand
        winning_player = player
      end
    end
    award = @bet_manager.award_pot winning_player
    hand_name = @hand_evaluator.get_hand_name(hand_value)
    puts "#{winning_player.name} wins #{award} with #{hand_name}."
  end

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
end
