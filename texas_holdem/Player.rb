
class Player
	attr_accessor :hand, :chips, :current_bet, :name, :computer

	def initialize(name)
		@hand = []
		@chips = 10000 #could probably change this to user input
		@name = name
		@current_bet = 0
		#@folded = false
		#@computer = computer?
	end

	def get_hand
		#if computer?
			#if folded
			#	"Folded"
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
end