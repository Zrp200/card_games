
class Player

	attr_accessor :hand, :chips, :current_bet #:folded, :computer

	def initialize()
		@hand = []
		@chips = 1000000 #could probably change this to user input
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

	#NEEDS TO RETURN TRUE IF THEY ARE STILL IN THE GAME AND FALSE IF NOT
	def bet?
		
		#if player.computer
			#calculate_win_odds
		#else
			#puts "Would you like to bet, check, or fold? (Enter amount between X and Y to bet):"
			#nput = 0   #$STDIN()
			#if input.downcase == "fold"
				#folded? = true
		#	end
		#end

		#folded?
	end

	
end