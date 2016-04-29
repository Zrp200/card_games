require_relative '../BetManager.rb'

class HoldemBetManager < BetManager

	def bet(players)
		manage_betters(players)
	end

end
