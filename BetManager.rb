#May need to make this more abstract as I add more games that use it
#RIGHT NOW, NOT HAVING ENOUGH MONEY RESULTS IN YOU FOLDING FOR THE HAND; WILL NEED TO INTRODUCE SIDE POTS
class BetManager
	attr_accessor :pot, :min_bet, :max_bet, :ante_amount, :total_bet, :side_pots

	def initialize
		@pot = 0
		@min_bet = 50
		@max_bet = 500
		@total_bet = 500
	end


	def manage_antes(ante_queue)
		(1..2).time do |number|
			player = get_first_player(ante_queue)
			pot += player.get_chips(ante_amout/number)
			put_player_at_end(player, ante_queue)
		end
	end

	def manage_betting_order(players)
		bets, checks_or_calls = 0
		
		while players.size > 1 && bets + checks < players.size
			player = ante_queue.shift
			player_bet = ask_for_bet(player)
			player_bet = analyze_bet(player_bet)
			
			if player_bet.is_a?(Fixnum)
				bets, checks_or_calls = 1, 0
			elsif player_bet = "Fold"
				next
			elsif player_bet = "Check"
				checks_or_calls += 1
			else #what do I need to do at this point in case of a call? Just add to var or do something with pot?
				checks_or_calls += 1
			end
			ante_queue.push(player)
		end
		players
	end

	def analyze_bet(player)
		bet = 0
		while true
			bet = ask_for_bet(player)
			if bet == "Fold"
				break
			elsif bet == "Check"
				if total_bet > player.current_bet
					puts "Incorrect input"
					next
				else
					break 
				end
			elsif bet == "Call"
				if total_bet == 0
					puts "Incorrect input"
					next
				else
					break
				end
			end

			bet = bet.match(/[0-9]*/).to_s.to_i
			if bet < min_bet || bet > max_bet
				next
			elsif bet > 0
				#Will need to alter this later for side pots
				#Should I wait to add to the pot?
				if bet > player.chips #THIS IS WHERE SIDEBETS WOULD COME INTO PLAY
					return "Fold"
				else
					#add_to_pot(bet)
					add_to_pot(bet)
					break
				end
			else
				puts "Incorrect input"
				next
			end
		end
		bet
	end

	def ask_for_bet(player)
		if player.current_bet > 0 #They have been raised
			puts "#{player.name}: Would you like to 'Call' the raise of #{total_bet - player.current_bet}, re-raise ('#{min_bet} - #{max_bet}') or 'Fold'?"
			input = $stdin.gets.strip
		elsif player.current_bet == 0 && total_bet > 0 # they have not yet bet
			puts "#{player.name}: Would you like to 'Call' the bet of #{total_bet - player.current_bet}, re-raise ('#{min_bet} - #{max_bet}'), or 'Fold'?"
			input = $stdin.gets.strip
		elsif player.current_bet == 0
			puts "#{player.name}: Would you like to bet ('#{min_bet} - #{max_bet}'), 'Check', 'Fold'?"
			input = $stdin.gets.strip
		else
			puts "You should not be here!"
		end
	end

	def add_to_pot(bet)
		@pot = pot.to_s.to_i + bet
	end

	def award_pot(player)
		player.chips += pot.to_s.to_i
		@pot = 0
	end
end

#x = BetManager.new
#puts bet = x.manage_betters()


