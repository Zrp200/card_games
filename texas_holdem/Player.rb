
class Player
	attr_accessor :hand, :chips, :current_bet, :name, :computer

	def initialize(name)
		@hand = []
		@chips = 1000000 #could probably change this to user input
		@name = name
		#@folded = false
		#@computer = computer?
	end

	def get_hand
		#if computer?
			#if folded
			#	"Folder"
			#else
			#	"Playing"
			#end
		#else	
			hand
		#end
	end

	def get_chips(amount)
		chips -= amount
		amount
	end

	def get_bet
		"Fold"
	end
end