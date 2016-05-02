require_relative './bet_manager'
require_relative './hand_evaluator'
require_relative './deck'
require_relative './player'

class TexasHoldemDealer
  def initialize players
    @deck = Deck.new
    @table = Player.new 'Table'
    @bet_manager = BetManager.new
    @currently_in_game = players
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
    winning_hand = @table.hand
    @currently_in_game.each do |player|
      combined_hand = player.combined_hand_with @table
      if combined_hand > winning_hand
        winning_player = player
        winning_hand = combined_hand
      end
    end
    award = @bet_manager.award_pot winning_player
    puts "#{winning_player.name} wins #{award} with #{winning_hand.name}."
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
