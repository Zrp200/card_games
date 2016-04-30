require_relative '../cards.rb'
require_relative './holdem_bet_manager.rb'
require_relative './player.rb'
require_relative './hand_evaluator.rb'

class TexasHoldemDealer
  include Cards

  attr_reader :players

  def initialize(bet_manager, hand_evaluator, players)
    @table = []
    @bet_manager = bet_manager
    @players = players
    @ante_queue = players.dup
    @currently_in_game = players.dup
    @hand_evaluator = hand_evaluator
  end

  def play_game
    @deck = build_deck(52)
  end

  def hole_cards
    player_cards = deal(2, 4, [])
    deal_to_players(player_cards)
    display_cards
    bet
  end

  def the_flop
    deal(3, 1, table)
    display_cards
    bet
  end

  def the_turn
    deal(1, 1, table)
    display_cards
    bet
  end

  def the_river
    deal(1, 1, table)
    display_cards
    bet
    determine_winner
  end

  private

  attr_reader :bet_manager, :currently_in_game, :deck, :hand_evaluator, :table

  def deal(num_of_cards, num_of_deals, location)
    (1..num_of_deals).each do
      card_one, card_two, card_three = deck.sample(num_of_cards)
      deck.delete(card_one) and location.push(card_one) unless card_one == nil
      deck.delete(card_two) and location.push(card_two) unless card_two == nil
      deck.delete(card_three) and location.push(card_three) unless card_three == nil
    end
    location
  end

  def deal_to_players(player_cards)
    currently_in_game.each do |player|
      player.hand << player_cards.shift
      player.hand << player_cards.shift
    end
  end

  #Add functionality to say what step in the deal it is
  #Should I make a separate class that handles the view?
  def display_cards
    currently_in_game.each do |player|
      puts "#{player.name}: #{player.hand}"
    end
    puts "Table: #{table}"
    puts '------------'
    puts '------------'
  end

  def bet
    players_who_bet = bet_manager.bet(currently_in_game)
    #Make sure betting order doesn't get messed up here
    currently_in_game = players_who_bet
  end

  def determine_winner
    hand_value, winning_hand = get_hand_value(table)
    winning_player = "The table"
    #change this to only examine players currently in the game
    @players.each do |player|
      value, hand = evaluate_hands(player.hand, @table)
      hand_value, winning_hand, winning_player = value, hand, player if value > hand_value
    end
    puts "#{winning_player.name} wins #{award_pot(winning_player)} with #{get_hand_name(hand_value)}."
  end

  def get_hand_value(hand)
    hand_evaluator.get_hand_value(table)
  end

  def evaluate_hands(hand, table)
    hand_evaluator.evaluate_hands(hand, table)
  end

  def get_hand_name(hand_value)
    hand_evaluator.get_hand_name(hand_value)
  end

  def award_pot(player)
    bet_manager.award_pot(player)
  end
end

game = TexasHoldemDealer.new(HoldemBetManager.new, HandEvaluator.new,
  [Player.new("Hays"), Player.new("Computer 1"), Player.new("Computer 2"), Player.new("Computer 3")])
game.play_game

game.hole_cards
game.the_flop
game.the_turn
game.the_river
puts '*******'
