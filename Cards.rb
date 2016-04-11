module Cards
	#Enum for cards
	#sends a deck to the dealer when asked
	#perhaps supply an optional arg for modifying the deck
	SUITS = ['c', 'd', 'h', 's']
	FACES = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2']

	SUIT_VALUES = {
		'c' => 0,
		'd' => 1,
		'h' => 2,
		's' => 3
	}

	FACE_VALUES = {
		'2' => 2,
		'3' => 3,
		'4' => 4,
		'5' => 5,
		'6' => 6,
		'7' => 7,
		'8' => 8,
		'9' => 9,
		'T' => 10,
		'J' => 11,
		'Q' => 12,
		'K' => 13,
		'A' => 14
	}

	def build_deck(number_of_cards)
		deck = []
		iterations = number_of_cards / 4

		SUITS.each do |suit|
			(0...iterations).each do |face|
				deck << (FACES[face] + suit)
			end
		end

		deck
	end
end