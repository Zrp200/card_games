require_relative '../BetManager.rb'

class HoldemBetManager < BetManager

	def bet(players)
		manage_betting_order(players)
		#players.each do |player|
		#	puts analyze_bet(player)
		#end
	end

end
