#May need to make this more abstract as I add more games that use it
class BetManager
	attr_accessor :pot, :min_bet, :max_bet, :ante_amount, :total_bet, :side_pots

	def manage_antes(ante_queue)
		(1..2).time do |number|
			player = get_first_player(ante_queue)
			pot += player.get_chips(ante_amout/number)
			put_player_at_end(player, ante_queue)
		end
	end

	def manage_betters(players)
		bets, checks_or_calls = 0
		
		while players.size > 1 && bets + checks < players.size
			player = get_first_player(ante_queue)
			player_bet = player.get_bet(player)
			
			if player_bet.is_a?(Fixnum)
				#it is either the first bet or a raise
				#either bets = 0 or 1 when it happens
				#in either case, reset the check/call count
				#then add this player to the end of the queue
			elsif player_bet = "Fold"
			
			elsif player_bet = "Check"
				
			else

			end
				
				
		end
		

		#TEST that it is communicating with other classes
		#if players.size < 2
		#	puts "There are not enough players"
		#else
		#	puts "Time to bet!"
		#end
	end

	def get_bet(player)
		bet = 0
		#case- current

		#while true
		#	bet = ask_for_bet
		#	if bet == "Fold"
		#		break
		#	elsif bet == "Check"
		#		break #unless total_bet > player.current_bet -- but if it is less, wouldn't i just treat that as a raise?
		#	elsif bet == "Call"
		#		break unless total_bet == 0 #then they must either check or bet
		#	elsif bet < min_bet || bet > max_bet
				#enter a number between min_bet and max_bet/call/or check
		#	else
		#		add_to_pot(bet)
		#	end
		#end
		bet
	end

	def ask_for_bet
		bet = player.get_bet
	end

	def add_to_pot(bet)
		#Is there a reason I should hold off on adding it to the pot?  Should I wait until the end and subtract the total bet from those still in the game?
		pot += bet
	end

	def award_pot(player)
		player.chips += pot
		pot = 0
	end
end

#x = BetManager.new
#puts bet = x.manage_betters()


