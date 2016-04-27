require_relative '../Cards.rb'

class HandEvaluator
	include Cards

	def evaluate_hand(hand, table)	
		suits = []
		faces = []
		combinations = [[hand[0]], [hand[1]], hand]
		hand_value = get_hand_value(table)

		combinations.each do |player_cards|
			#Return hand_value and hand
			value = get_all_card_combinations(player_cards, table) 
			#hand_value = value if value > hand_value
			break
		end
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
			#puts hand
			puts value
			puts '---------'
			#hand_value = value if value > hand_value
		end

		hand_value
	end

	def get_hand_value(hand)
		
		hand.sort!{ |x,y| get_face_value(x[0]) <=> get_face_value(y[0])}
		faces, suits = split_hand(hand) 
		get_face_values(faces)
		get_suit_values(suits)
		
		multiples_evaluation = check_for_multiples(faces)
		flush_evaluation = check_for_flush(suits.uniq)
		straight_evaluation = check_for_straight(faces)
		
	end

	def split_hand(hand)
		faces, suits = hand.map {|card| card.split('')}.transpose
	end

	def check_for_multiples(faces)
		score = -1
		multiples = faces.select {|face| faces.count(face) > 1}
		multiples.uniq!
		
		if multiples.size == 1
			case number = faces.count(multiples[0])
			when 2
				score("Pair")
			when 3
				score("Three of a Kind")
			when 4
				score("Four of a Kind")
			else
				"You should never be here!"
			end
		elsif multiples.size == 2
			number = faces.count(multiples[0])
			number2 = faces.count(multiples[1])
			if number == 2 && number2 == 3
				score("Full House")
			elsif number == 3 && number2 == 2
				score("Full House")
			else
				score("Two Pair")
			end
		else
			-1
		end
	end

	def check_for_flush(suits)
		if suits.size == 1
			score("Flush", suits[0])
		else
			-1
		end
	end

	def check_for_straight(faces)
		if faces.sort.each_cons(2).all? { |x,y| y == x + 1 }
			score("Straight", faces[4])
		else
			-1
		end
	end

	def score(hand, *args)
		#Need to convert args into the card face value (in most cases)
		case hand
		when "Pair"
			#pair = (card_value * 10) Range: 20-140
			#args[0] * 10
			puts "Score: pair"
		when "Two Pair"
			#two_pair = ((13 + higher_pair_value) * 10 + second_pair_card_value) Range: 152-284
			#(args[0] + 13) * 10 + args[1]
			puts "Score: two pair"
		when "Three of a Kind"
			#three_of_kind = ((1 + card_value) * 100) Range: 300-1500
			#(args[0] + 1) * 100
			puts "Score: three"
		when "Straight"
			#args[0] * 400
			puts "Score: straight"
		when "Flush"
			#flush = (5800) Range: 5800
			#5800
			puts "Score: flush"
		when "Full House"
			#full_house = (2 * three_of_a_kind_score * 10 + second_pair_card_value) Range: 6003-30013
			#(1 + args[0]) * 200 + args[1]
			puts "Score: full"
		when "Four of a Kind"
			#four_of_kind = ((2 + card_value) * 10000) Range: 40000 - 160000
			#(args[0] + 2) * 10000
			puts "Score: four" 
		else
			#high_card = card_value
			#args[0]
			puts "You should never be here!"
		end	
	end

	def get_suit_values(suits)
		suits.map! {|suit| suit = get_suit_value(suit)}
	end

	def get_face_values(faces)
		faces.map! {|face| get_face_value(face)}
	end

end

hand_evaluator = HandEvaluator.new()
hand = ['8c', '9h']
table = ['6s', '8c', '9c', '8c', 'Tc']

hand_evaluator.evaluate_hand(hand, table)

