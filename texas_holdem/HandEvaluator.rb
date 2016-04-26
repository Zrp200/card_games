require_relative '../Cards.rb'

class HandEvaluator
	include Cards

	def evaluate_hand(hand, table)
		
		suits = []
		faces = []
		combinations = [[hand[0]], [hand[1]], hand]
		hand_value = get_hand_value(table)

		combinations.each do |player_cards|
			value = get_all_card_combinations(player_cards, table) 
			#hand_value = value if value > hand_value
			break
		end

		#right now I'm adding all together; will eventually need to keep
		#seperate to make sure I try out all combos with player hand
		#hand.map { |card| 
		#	face, suit = card.split('') 
		#	faces << face; suits << suit; 
		#}
		
		#table.map { |card| 
		#	face, suit = card.split('') 
		#	faces << face; suits << suit;
		#}


		#check_suit_values(suits)
		#check_face_values(faces)
	end

	def get_all_card_combinations(player_cards, table)

		if player_cards.size == 1
			combinations_with_one_card(player_cards, table)
		else
			combinations_with_two_cards(player_cards, table)
		end

	end

	def combinations_with_two_cards(player_cards, table)
		x, y, z = 0, 1, 2
		hand_value = 0

		#There are 10 total combinations
		#Rather than 10, should have the combos be situational 
		10.times do ||
			hand = [player_cards[0], player_cards[1]]
			if z == 4 && y == 3 && x == 2
				hand += [table[x], table[y], table[z]]
				value = get_hand_value(hand)
				hand_value = value if value > hand_value
				break
			elsif z == 4 && y == 3
				hand += [table[x], table[y], table[z]]
				value = get_hand_value(hand)
				hand_value = value if value > hand_value
				x += 1; y = x + 1; z = y + 1;
			elsif z == 4
				hand += [table[x], table[y], table[z]]
				value = get_hand_value(hand)
				hand_value = value if value > hand_value
				y += 1; z = y + 1;
			else
				hand += [table[x], table[y], table[z]]
				value = get_hand_value(hand)
				hand_value = value if value > hand_value
				z += 1;
			end
		end

		hand_value
	end

	def combinations_with_one_card(player_cards, table)
		hand_value = 0

		#There are 5 total combinations
		(0..4).each do |skip_index|
			hand = [player_cards[0]] 
			(0..4).each do |current_index|
				if current_index != skip_index
					hand << table[current_index]
				end
			end
			value =  get_hand_value(hand)
			puts hand
			puts value
			puts '---------'
			#hand_value = value if value > hand_value
		end

		hand_value
	end

	def get_hand_value(hand)
		
		#I'll need to return the hand score and the high card
		hand.sort!{ |x,y| get_face_value(x[0]) <=> get_face_value(y[0])}
		high_card = hand[4]
		faces, suits = split_hand(hand) 
		
		multiples_evaluation = check_for_multiples(faces)
		score(multiples_evaluation) unless multiples_evaluation.size < 1
		
		#check_for_straight(faces)
		#score(straight)
		#flush_evaluation = check_for_flush(suits)


	end

	def split_hand(hand)
		faces, suits = hand.map {|card| card.split('')}.transpose
	end

	def check_for_multiples(faces)
		multiples = faces.select {|face| faces.count(face) > 1}
		multiples.uniq!

		if multiples.size == 1
			number = faces.count(multiples[0])
			
		elsif multiples.size == 2
			number = faces.count(multiples[0])
			number2 = faces.count(multiples[1])
			puts "hello"
			return [multiples[0], number, multiples[1], number]
		else
			return []
		end
	end

	def check_for_flush(suits)
		suits = suits.uniq
		if suits.size == 1
			return
		else
			return -1
		end
	end

	def score(hand, args*)
		#Need to convert args into the card face value (in most cases)
		case hand
		when 0
			args[0] * 10
		when 1
			(args[0] + 13) * 10 + args[1]
		when 2
			(args[0] + 1) * 100
		when 3
			args[0] * 400
		when 4
			5800
		when 5
			(1 + args[0]) * 200 + args[1]
		when 6
			(args[0] + 2) * 10000
		when 7
			1000000 + args[0]
		else
			args[0]
		end	
	end


	def check_suit_values(suits)
		suits.each do |suit|
			puts get_suit_value(suit)
		end
	end

	def check_face_values(faces)
		faces.each do |face|
			puts get_face_value(face)
		end
	end

end

hand_evaluator = HandEvaluator.new()
hand = ['8c', '9h']
table = ['As', '8d', 'Jc', 'Kc', 'Tc']

hand_evaluator.evaluate_hand(hand, table)

