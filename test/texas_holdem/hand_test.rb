require_relative '../test_helper.rb'
require_relative '../../lib/texas_holdem/card'
require_relative '../../lib/texas_holdem/hand'
require_relative '../../lib/texas_holdem/extra_cards'

class HandTest < Minitest::Test
  def test_high_card
    hand = Hand.new Card.new(:two  , :hearts  ),
                     Card.new(:seven, :hearts  ),
                     Card.new(:eight, :spades  ),
                     Card.new(:ten  , :spades  ),
                     Card.new(:king , :diamonds)
    assert_equal 'High Card', hand.name
  end

 

  def test_pair_is_pair
    hand = Hand.new Card.new(:two  , :hearts  ),
                    Card.new(:seven, :hearts  ),
                    Card.new(:seven, :spades  ),
                    Card.new(:ten  , :spades  ),
                    Card.new(:king , :diamonds)
    assert_equal 'a Pair', hand.name
  end

  def test_two_pair_is_two_pair
    hand = Hand.new Card.new(:two  , :hearts  ),
                    Card.new(:seven, :hearts  ),
                    Card.new(:seven, :spades  ),
                    Card.new(:king , :spades  ),
                    Card.new(:king , :diamonds)
    assert_equal 'Two Pair', hand.name
  end

  def test_trips_is_trips
    hand = Hand.new Card.new(:two  , :hearts  ),
                    Card.new(:king , :hearts  ),
                    Card.new(:seven, :spades  ),
                    Card.new(:king , :spades  ),
                    Card.new(:king , :diamonds)
    assert_equal 'Three of a Kind', hand.name
  end

  def test_straight_is_straight
    hand = Hand.new Card.new(:two  , :hearts  ),
                    Card.new(:three, :hearts  ),
                    Card.new(:four , :spades  ),
                    Card.new(:five , :spades  ),
                    Card.new(:six  , :diamonds)
    assert_equal 'a Straight', hand.name
  end

  def test_flush_is_flush
    hand = Hand.new Card.new(:two  , :spades),
                    Card.new(:three, :spades),
                    Card.new(:four , :spades),
                    Card.new(:king , :spades),
                    Card.new(:six  , :spades)
    assert_equal 'a Flush', hand.name
  end

  def test_full_house_is_full_house
    hand = Hand.new Card.new(:two , :hearts  ),
                    Card.new(:two , :spades  ),
                    Card.new(:two , :spades  ),
                    Card.new(:king, :diamonds),
                    Card.new(:king, :spades  )
    assert_equal 'a Full House', hand.name
  end

  def test_quads_is_quads
    hand = Hand.new Card.new(:two , :hearts  ),
                    Card.new(:two , :spades  ),
                    Card.new(:two , :spades  ),
                    Card.new(:two , :diamonds),
                    Card.new(:king, :spades  )
    assert_equal 'Four of a Kind', hand.name
  end

  def test_straight_flush_is_straight_flush_edge_case_1
    hand = Hand.new Card.new(:five , :spades),
                    Card.new(:two  , :spades),
                    Card.new(:three, :spades),
                    Card.new(:four , :spades),
                    Card.new(:ace  , :spades)
    assert_equal 'a Straight Flush', hand.name
  end

  def test_straight_flush_is_straight_flush_edge_case_2
    hand = Hand.new Card.new(:nine , :diamonds),
                    Card.new(:ten  , :diamonds),
                    Card.new(:jack , :diamonds),
                    Card.new(:queen, :diamonds),
                    Card.new(:king , :diamonds)
    assert_equal 'a Straight Flush', hand.name
  end

  def test_royal_flush_is_royal_flush
    hand = Hand.new Card.new(:ten  , :diamonds),
                    Card.new(:jack , :diamonds),
                    Card.new(:queen, :diamonds),
                    Card.new(:king , :diamonds),
                    Card.new(:ace  , :diamonds)
    assert_equal 'a Royal Flush', hand.name
  end

  def test_higher_card_wins
    higher = Hand.new Card.new(:two  , :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:eight, :spades  ),
                      Card.new(:ten  , :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:two  , :diamonds),
                     Card.new(:seven, :spades  ),
                     Card.new(:eight, :clubs   ),
                     Card.new(:ten  , :clubs   ),
                     Card.new(:jack , :diamonds)
    assert(higher > lower)
  end

  def test_higher_pair_wins
    higher = Hand.new Card.new(:two  , :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:seven, :spades  ),
                      Card.new(:ten  , :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:two  , :diamonds),
                     Card.new(:two  , :spades  ),
                     Card.new(:eight, :clubs   ),
                     Card.new(:ten  , :clubs   ),
                     Card.new(:jack , :diamonds)
    assert(higher > lower)
  end

  

  def test_higher_pair_of_two_pair_wins
    higher = Hand.new Card.new(:four, :hearts  ),
                      Card.new(:five, :hearts  ),
                      Card.new(:five, :spades  ),
                      Card.new(:ace , :spades  ),
                      Card.new(:ace , :diamonds)
    lower = Hand.new Card.new(:jack , :diamonds),
                     Card.new(:queen, :clubs   ),
                     Card.new(:queen, :clubs   ),
                     Card.new(:king , :clubs   ),
                     Card.new(:king , :hearts  )
    assert(higher > lower)
  end

  def test_higher_trips_wins
    higher = Hand.new Card.new(:four, :hearts  ),
                      Card.new(:five, :hearts  ),
                      Card.new(:five, :spades  ),
                      Card.new(:five, :spades  ),
                      Card.new(:ace , :diamonds)
    lower = Hand.new Card.new(:jack , :diamonds),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:king , :hearts  )
    assert(higher > lower)
  end

  def test_higher_straight_wins
    higher = Hand.new Card.new(:jack , :diamonds),
                     Card.new(:nine , :clubs    ),
                     Card.new(:ten  , :clubs    ),
                     Card.new(:queen, :clubs    ),
                     Card.new(:king , :hearts   )
    lower = Hand.new Card.new(:ace  , :hearts   ),
                      Card.new(:two  , :hearts  ),
                      Card.new(:three, :spades  ),
                      Card.new(:five , :spades  ),
                      Card.new(:four , :diamonds)                 
    assert(higher > lower)
  end

  def test_higher_flush_wins
    higher = Hand.new Card.new(:four, :spades),
                      Card.new(:five, :spades),
                      Card.new(:five, :spades),
                      Card.new(:five, :spades),
                      Card.new(:ace , :spades)
    lower = Hand.new Card.new(:jack , :spades),
                     Card.new(:three, :spades),
                     Card.new(:three, :spades),
                     Card.new(:three, :spades),
                     Card.new(:king , :spades)
    assert(higher > lower)
  end

  def test_higher_full_house_wins
    higher = Hand.new Card.new(:ace , :hearts  ),
                      Card.new(:five, :hearts  ),
                      Card.new(:five, :spades  ),
                      Card.new(:ace , :spades  ),
                      Card.new(:ace , :diamonds)
    lower = Hand.new Card.new(:king , :diamonds),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:king , :clubs   ),
                     Card.new(:king , :hearts  )
    assert(higher > lower)
  end

  def test_higher_quads_wins
    higher = Hand.new Card.new(:ace , :hearts  ),
                      Card.new(:five, :hearts  ),
                      Card.new(:five, :spades  ),
                      Card.new(:five, :spades  ),
                      Card.new(:five, :diamonds)
    lower = Hand.new Card.new(:king , :diamonds),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :hearts  )
    assert(higher > lower)
  end

  def test_higher_straight_flush_wins
    higher = Hand.new Card.new(:jack , :diamonds),
                      Card.new(:nine , :diamonds),
                      Card.new(:ten  , :diamonds),
                      Card.new(:queen, :diamonds),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:jack , :hearts),
                     Card.new(:ten  , :hearts),
                     Card.new(:nine , :hearts),
                     Card.new(:eight, :hearts),
                     Card.new(:seven, :hearts)                 
    assert(higher > lower)
  end

  def test_second_high_card_determines_winner
    higher = Hand.new Card.new(:two  , :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:eight, :spades  ),
                      Card.new(:ten  , :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:two  , :hearts  ),
                     Card.new(:seven, :hearts  ),
                     Card.new(:eight, :spades  ),
                     Card.new(:nine , :spades  ),
                     Card.new(:king , :diamonds)
    assert(higher > lower)
  end

  def test_third_high_card_determines_winner
    higher = Hand.new Card.new(:two  , :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:eight, :spades  ),
                      Card.new(:ten  , :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:two  , :hearts  ),
                     Card.new(:three, :hearts  ),
                     Card.new(:seven, :spades  ),
                     Card.new(:ten  , :spades  ),
                     Card.new(:king , :diamonds)
    assert(higher > lower)
  end

  def test_fourth_high_card_determines_winner
    higher = Hand.new Card.new(:two  , :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:eight, :spades  ),
                      Card.new(:nine , :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:two  , :hearts  ),
                     Card.new(:five , :hearts  ),
                     Card.new(:eight, :spades  ),
                     Card.new(:nine , :spades  ),
                     Card.new(:king , :diamonds)
    assert(higher > lower)
  end

  def test_high_card_wins_if_equal_pair
    higher = Hand.new Card.new(:two  , :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:seven, :spades  ),
                      Card.new(:ten  , :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:seven, :diamonds),
                     Card.new(:seven, :spades  ),
                     Card.new(:eight, :clubs   ),
                     Card.new(:ten  , :clubs   ),
                     Card.new(:jack , :diamonds)
    assert(higher > lower)
  end

  def test_high_card_wins_if_equal_pair2
    higher = Hand.new Card.new(:nine , :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:seven, :spades  ),
                      Card.new(:ten  , :spades  ),
                      Card.new(:jack , :diamonds)
    lower = Hand.new Card.new(:seven, :diamonds),
                     Card.new(:seven, :spades  ),
                     Card.new(:eight, :clubs   ),
                     Card.new(:ten  , :clubs   ),
                     Card.new(:jack , :diamonds)
    assert(higher > lower)
  end

  def test_higher_low_pair_wins_if_equal_high_pair
    higher = Hand.new Card.new(:three, :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:seven, :spades  ),
                      Card.new(:three, :spades  ),
                      Card.new(:two , :diamonds)
    lower = Hand.new Card.new(:two  , :diamonds),
                     Card.new(:seven, :spades  ),
                     Card.new(:seven, :clubs   ),
                     Card.new(:two  , :clubs   ),
                     Card.new(:jack , :diamonds)
    assert(higher > lower)
  end

  def test_high_card_wins_if_equal_two_pair
    higher = Hand.new Card.new(:three, :hearts  ),
                      Card.new(:seven, :hearts  ),
                      Card.new(:seven, :spades  ),
                      Card.new(:three, :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:three, :diamonds),
                     Card.new(:seven, :spades  ),
                     Card.new(:seven, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:jack , :diamonds)
    assert(higher > lower)
  end

  def test_high_card_wins_if_equal_trips
    higher = Hand.new Card.new(:four, :hearts  ),
                      Card.new(:five, :hearts  ),
                      Card.new(:five, :spades  ),
                      Card.new(:five, :spades  ),
                      Card.new(:ace , :diamonds)
    lower = Hand.new Card.new(:jack, :diamonds),
                     Card.new(:five, :clubs   ),
                     Card.new(:five, :clubs   ),
                     Card.new(:five, :clubs   ),
                     Card.new(:king, :hearts  )
    assert(higher > lower)
  end

  def test_second_high_card_wins_if_equal_trips
    higher = Hand.new Card.new(:jack , :hearts  ),
                      Card.new(:three, :hearts  ),
                      Card.new(:three, :spades  ),
                      Card.new(:three, :spades  ),
                      Card.new(:king , :diamonds)
    lower = Hand.new Card.new(:four , :diamonds),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:king , :hearts  )
    assert(higher > lower)
  end

  def test_flush_with_higher_cards_wins1
    higher = Hand.new Card.new(:four, :spades),
                      Card.new(:two , :spades),
                      Card.new(:five, :spades),
                      Card.new(:jack, :spades),
                      Card.new(:ace , :spades)
    lower = Hand.new Card.new(:two  , :spades),
                     Card.new(:eight, :spades),
                     Card.new(:nine , :spades),
                     Card.new(:three, :spades),
                     Card.new(:ace  , :spades)
    assert(higher > lower)
  end

  def test_flush_with_higher_cards_wins2
    higher = Hand.new Card.new(:four, :spades),
                      Card.new(:two , :spades),
                      Card.new(:five, :spades),
                      Card.new(:jack, :spades),
                      Card.new(:ace , :spades)
    lower = Hand.new Card.new(:two  , :spades),
                     Card.new(:five , :spades),
                     Card.new(:jack , :spades),
                     Card.new(:three, :spades),
                     Card.new(:ace  , :spades)
    assert(higher > lower)
  end

  def test_higher_second_pair_wins_with_full_house
    higher = Hand.new Card.new(:ace , :hearts  ),
                      Card.new(:five, :hearts  ),
                      Card.new(:five, :spades  ),
                      Card.new(:ace , :spades  ),
                      Card.new(:ace , :diamonds)
    lower = Hand.new Card.new(:ace  , :diamonds),
                     Card.new(:three, :clubs   ),
                     Card.new(:three, :clubs   ),
                     Card.new(:ace  , :clubs   ),
                     Card.new(:ace  , :hearts  )
    assert(higher > lower)
  end
end
