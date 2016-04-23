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
		
		#Royal/straight flush: "(2345A|23456|34567|...|9TJQK|TJQKA)#(\\w)\\1{4}"
		#Four of a kind:       ".*(\\w)\\1{3}.*#.*"
		#Full house:           "((\\w)\\2\\2(\\w)\\3|(\\w)\\4(\\w)\\5\\5)#.*"
		#Flush:                ".*#(\\w)\\1{4}"
		#Straight:             "(2345A|23456|34567|...|9TJQK|TJQKA)#.*"
		#Three of a kind:      ".*(\\w)\\1\\1.*#.*"
		#Two pair:             ".*(\\w)\\1.*(\\w)\\2.*#.*"
		#One pair:             ".*(\\w)\\1.*#.*"
		#High card:            (none)
		
		1
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
table = ['Ts', 'Jd', 'Qc', 'Kc', 'Ac']

hand_evaluator.evaluate_hand(hand, table)

