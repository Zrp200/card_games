require '/Users/hayshopkins/Desktop/ruby_projects/card_games/Cards.rb'
require '/Users/hayshopkins/Desktop/ruby_projects/card_games/texas_holdem/Player.rb'
require '/Users/hayshopkins/Desktop/ruby_projects/card_games/texas_holdem/Computer.rb'


class TexasHoldemDealer
	include Cards

	attr_accessor :deck, :table, :players, :pot
	
	def initialize(table, players)
		@table = table
		@players = players
		@ante_queue = players
		@pot = 0
	end

	def play_game
		@deck = build_deck(52)
		#HOW DO I KEEP TRACK OF WHOSE TURN IT IS TO ANTE?
		#Use an array of players like a queue
		#ante
	end

	def hole_cards

		player_cards = deal(2, 4, [])
		puts player_cards
		deal_to_players(player_cards)
		display_cards
		#bet
	end

	def the_flop
		deal(3, 1, table)
		display_cards
		#bet
	end

	def the_turn
		#put 1 card on the table
		deal(1, 1, table)
		display_cards
		#bet
	end

	def the_river
		deal(1, 1, table)
		display_cards
		#final bet
		#determine_winner
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
			player.hand << player_cards.shift(2)
		end

	end

	#MOVE THIS INTO ITS OWN CLASS SOON; USE CLASS METHODS?
	def display_cards

		player_number = 1
		players.each do |player|
			puts "Player #{player_number}: #{player.get_hand}"
			player_number += 1
		end
		puts "Table: #{table}"
		sleep(2)

	end

	#SHOULD THE DEALER CONTROL THIS OR SHOULD I MAKE A SEPARATE 'HOUSE RULES'
	#CLASS THAT KEEPS TRACK OF BETTING LIMITS ETC.
	def bet?

		players.each do |player|
			if player.is_a? Computer

			else
				puts "Would you like to bet, check, or fold? (Enter amount between X and Y to bet):"
				input = 0   #$STDIN()
				if input.downcase == "fold"

				end
			end
		end
		
	end



	#CARD EVALUATOR SHOULD BE ITS OWN CLASS...OR A MODULE
	def determine_winner

	end
end

game = TexasHoldemDealer.new([], [Player.new, Computer.new, Computer.new, Computer.new])

#while true
deck = game.play_game

deck.each do |card|
	face, suit = card.split('')
	puts "#{card}: #{Cards::FACE_VALUES[face]}, #{Cards::SUIT_VALUES[suit]}"
end
	#game.hole_cards
	#game.the_flop
	#game.the_turn
	#game.the_river
	#puts "Goodbye!"
	#game.play_again ?  next : break
	#game.new_round #reset what needs to be reset here
#end





