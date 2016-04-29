require_relative '../Cards.rb'
require_relative './HoldemBetManager.rb'
require_relative './Player.rb'
require_relative './HandEvaluator.rb'

class TexasHoldemDealer
	include Cards

	attr_accessor :deck, :table, :players, :currently_in_game, :bet_manager, :hand_evaluator, :ante_queue
	
	def initialize(bet_manager, hand_evaluator, players)
		@table = []
		@bet_manager = bet_manager
		@players = players
		@ante_queue = players
		@currently_in_game = players
		@hand_evaluator = hand_evaluator
	end

	def play_game
		@deck = build_deck(52)
		collect_antes
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

	def collect_antes
		bet_manager.collect_antes(ante_queue)
	end

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
		players.each do |player|
			player.hand << player_cards.shift
			player.hand << player_cards.shift
		end
	end

	#Add functionality to say what step in the deal it is
	#Should I make a separate class that handles the view?
	def display_cards
		player_number = 1
		players.each do |player|
			puts "#{player.name}: #{player.get_hand}"
			player_number += 1
		end
		puts "Table: #{table}"
		#sleep(2)
		puts '------------'
		puts '------------'
	end

	def bet
		bet_manager.bet(currently_in_game)
	end

	def determine_winner
		hand_value, winning_hand = get_hand_value(table)
		winning_player = "The table"

		#change this to only examine players currently in the game
		@players.each do |player|
			value, hand = evaluate_hand(player.hand, @table)
			hand_value, winning_hand, winning_player = value, hand, player.name if value > hand_value
		end
		hand_name = get_hand_name(hand_value)
		puts "#{winning_player} won with #{hand_name}."
	end

	def get_hand_value(hand)
		@hand_evaluator.get_hand_value(hand)
	end

	def evaluate_hand(hand, table)
		@hand_evaluator.evaluate_hand(hand, table)
	end

	def get_hand_name(hand_value)
		@hand_evaluator.get_hand_name(hand_value)
	end
end


game = TexasHoldemDealer.new(HoldemBetManager.new, HandEvaluator.new, 
	[Player.new("Hays"), Player.new("Computer 1"), Player.new("Computer 2"), Player.new("Computer 3")])
game.play_game

while true
	game.hole_cards
	game.the_flop
	game.the_turn
	game.the_river
	break
	#game.play_again ?  next : break
	#game.new_round #reset what needs to be reset here
end





