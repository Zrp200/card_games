require_relative './pot'
require_relative './hand_evaluator'
require_relative './deck'
require_relative './player'

class TexasHoldemDealer
  def initialize players
    @deck = Deck.new
    @table = Player.new 'Table'
    @pot = Pot.new
    @currently_in_game = players
  end

  def play_game
    hole_cards
    the_flop
    the_turn
    the_river
    puts '*******'
    determine_winner
  end

  private

  def round(deal_amt, target=@table)
	@deck.deal deal_amt, target
	display_cards
	bet
  end

  def hole_cards
    round 2, *@currently_in_game
  end

  def the_flop
    round 3
  end

  def the_turn
    round 1
  end
  alias the_river the_turn

  def determine_winner
    winning_player = @table
    winning_hand = @table.hand
    @currently_in_game.each do |player|
      combined_hand = player.combined_hand_with @table
      if combined_hand > winning_hand
        winning_player = player
        winning_hand = combined_hand
      end
    end
    puts "#{winning_player.name} wins #{@pot.award_pot winning_player} with #{evaluator.get_hand_name winning_value}."
  end

  def display_cards
    @currently_in_game.each { |player| puts player }
    puts @table
    puts '------------'
    puts '------------'
  end



          ### --- Betting --- ###



  def manage_betting_order
    bets, checks_or_calls = 0, 0
    while @currently_in_game.size > 1 && bets + checks_or_calls < @currently_in_game.size
      player = @currently_in_game.shift
      player_bet = get_bet_value player
      if player_bet.is_a? Fixnum
        bets, checks_or_calls = 1, 0
        @pot.total_bet += player.get_chips(player_bet)
      elsif player_bet == "fold"
        next
      elsif player_bet == "check"
        checks_or_calls += 1
      else
        checks_or_calls += 1
        bet = player.get_chips(@pot.total_bet-player.current_bet)
        @pot.add_to_pot(bet)
      end
      @currently_in_game.push(player)
    end
    reset_bets
  end
  alias bet manage_betting_order
  def get_bet_value(player)
    bet = 0
    loop do
      response = get_bet(player)
      if response == "fold"
        break
      elsif response == "check"
        if @pot.total_bet > player.current_bet
          puts "Incorrect input"
          next
        else
          break
        end
      elsif response == "call"
        if @pot.total_bet == 0
          puts "Incorrect input"
          next
        else
          break
        end
      end
      bet = response.match(/[0-9]*/).to_s.to_i
      if bet < @pot.min_bet || bet > @pot.max_bet
        next
      elsif bet > 0
        #Will need to alter this later for side pots
        #Should I wait to add to the pot?
        if bet > player.chips #THIS IS WHERE SIDEBETS WOULD COME INTO PLAY
          return "fold"
        else
          return bet
        end
      else
        puts "Incorrect input"
        next
      end
    end
    response
  end

  def get_bet(player)
    if player.current_bet > 0
      puts "#{player.name}: Would you like to 'Call' the raise of #{@pot.total_bet - player.current_bet}, re-raise ('#{@pot.min_bet} - #{@pot.max_bet}') or 'Fold'?"
      input = $stdin.gets.strip.downcase
    elsif player.current_bet == 0 && @pot.total_bet > 0
      puts "#{player.name}: Would you like to 'Call' the bet of #{@pot.total_bet - player.current_bet}, raise ('#{@pot.min_bet} - #{@pot.max_bet}'), or 'Fold'?"
      input = $stdin.gets.strip.downcase
    elsif player.current_bet == 0
      puts "#{player.name}: Would you like to bet ('#{@pot.min_bet} - #{@pot.max_bet}'), 'Check', 'Fold'?"
      input = $stdin.gets.strip.downcase
    else
      puts "You should not be here!"
    end
  end

  def reset_bets
    @pot.total_bet = 0
    @currently_in_game.each { |player| player.reset_bet }
  end
end
