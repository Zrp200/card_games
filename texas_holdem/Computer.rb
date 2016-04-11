
class Computer

	attr_accessor :hand, :folded, :chips, :current_bet

	def initialize
		@hand = []
		@chips = 1000000
		@folded = false
	end

	def get_hand
		
		if folded
			"Folder"
		else
			"Playing"
		end

	end
end