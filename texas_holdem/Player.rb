
class Player

	attr_accessor :hand, :chips

	def initialize
		@hand = []
		@chips = 1000000
	end

	def get_hand
		hand
	end
end