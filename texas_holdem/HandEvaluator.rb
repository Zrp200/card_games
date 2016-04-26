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
			hand_value = value if value > hand_value
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
			hand_value = value if value > hand_value
		end

		hand_value
	end

	def get_hand_value(hand)
		
		#I'll need to return the hand score and the high card
		hand.sort! { |x,y| get_face_value(x[0]) <=> get_face_value(y[0])}
		high_card = hand[4]
		faces, suits = []
		
		hand.each { |card|
		face, suit = card.split('') 
			faces << face; suits << suit; 
		}

		#i'll need to get back a total hand value and a high card
		check_for_multiples(faces)
		check_for_straight(faces)
		check_for_flush(suits)
		
		1
	end

	def check_for_multiples(faces)
		faces = faces.uniq
		if hand.size == 5
			return;
		elsif hand.size == 4
			get_pair()
		elsif hand.size == 3
			get_three_of_kind_or_two_pair()
		elsif hand.size == 2
			get_four_of_kind_or_full_house()
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
table = ['As', 'Jd', '6c', 'Kc', 'Tc']

hand_evaluator.evaluate_hand(hand, table)

