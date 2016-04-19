require_relative '../Cards.rb'

class HandEvaluator
	include Cards
	
	def evaluate_hand(hand, table)
		suits = []
		faces = []

		#right now I'm adding all together; will eventually need to keep
		#seperate to make sure I try out all combos with player hand
		hand.map { |card| 
			face, suit = card.split('') 
			faces << face; suits << suit; 
		}
		
		table.map { |card| 
			face, suit = card.split('') 
			faces << face; suits << suit;
		}


		check_suit_values(suits)
		check_face_values(faces)
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

