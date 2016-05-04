require_relative '../test_helper.rb'
require_relative '../../lib/texas_holdem/card'
require_relative '../../lib/texas_holdem/hand'

class HandTest < Minitest::Test
  def test_high_card
    cards = [
      Card.new(:two  , :hearts  ),
      Card.new(:seven, :hearts  ),
      Card.new(:eight, :spades  ),
      Card.new(:ten  , :spades  ),
      Card.new(:king , :diamonds)
    ]
    hand = Hand.new(*cards)
    assert_equal 'High Card', hand.name
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

  def test_pair_is_pair
    skip
    cards = [
      Card.new(:two  , :hearts  ),
      Card.new(:seven, :hearts  ),
      Card.new(:seven, :spades  ),
      Card.new(:ten  , :spades  ),
      Card.new(:king , :diamonds)
    ]
    hand = Hand.new(*cards)
    assert_equal 'a Pair', hand.name
  end

  def test_next_highest_card_wins_one
    skip
    higher = Hand.new Card.new(:two, :hearts   ),
                      Card.new(:seven, :hearts ),
                      Card.new(:eight, :spades ),
                      Card.new(:jack, :spades  ),
                      Card.new(:king, :diamonds)
    lower = Hand.new Card.new(:two, :spades  ),
                     Card.new(:seven, :spades),
                     Card.new(:eight, :clubs ),
                     Card.new(:ten, :clubs   ),
                     Card.new(:king, :clubs  )
    assert(higher > lower)
  end
 
  def test_next_highest_card_wins_two
    skip
    higher = Hand.new Card.new(:two, :hearts   ),
                      Card.new(:seven, :hearts ),
                      Card.new(:eight, :spades ),
                      Card.new(:jack, :spades  ),
                      Card.new(:king, :diamonds)
    lower = Hand.new Card.new(:two, :diamonds ),
                     Card.new(:six, :spades   ),
                     Card.new(:seven, :clubs  ),
                     Card.new(:jack, :clubs   ),
                     Card.new(:king, :diamonds)
    assert(higher > lower)
  end

  def test_next_highest_card_wins_three
    skip
    higher = Hand.new Card.new(:two, :hearts  ),
                      Card.new(:seven, :hearts),
                      Card.new(:eight, :spades),
                      Card.new(:jack, :spades ),
                      Card.new(:king, :spades )
    lower = Hand.new Card.new(:two, :diamonds ),
                     Card.new(:six, :spades   ),
                     Card.new(:eight, :clubs  ),
                     Card.new(:jack, :clubs   ),
                     Card.new(:king, :diamonds)
    assert(higher > lower)
  end

  def test_next_highest_card_wins_four
    skip
    higher = Hand.new Card.new(:three, :hearts ),
                      Card.new(:seven, :hearts ),
                      Card.new(:eight, :spades ),
                      Card.new(:jack, :spades  ),
                      Card.new(:king, :diamonds)
    lower = Hand.new Card.new(:two, :diamonds ),
                     Card.new(:seven, :spades ),
                     Card.new(:eight, :clubs  ),
                     Card.new(:jack, :clubs   ),
                     Card.new(:king, :diamonds)
    assert(higher > lower)
  end

  def test_snafu_highest_card_comparison
    skip
    higher = Hand.new Card.new(:ace, :hearts  ),
                      Card.new(:two, :hearts  ),
                      Card.new(:three, :spades),
                      Card.new(:four, :spades ),
                      Card.new(:six, :diamonds)
    lower = Hand.new Card.new(:king, :diamonds ),
                     Card.new(:queen, :spades  ),
                     Card.new(:jack, :clubs    ),
                     Card.new(:ten, :clubs     ),
                     Card.new(:eight, :diamonds)
    assert(higher > lower)
  end

  

  def test_higher_pair_wins
    skip
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

  def test_equal_pair_with_higher_card_wins
    skip
    higher = Hand.new Card.new(:two, :hearts   ),
                      Card.new(:seven, :hearts ),
                      Card.new(:seven, :spades ),
                      Card.new(:ten, :spades   ),
                      Card.new(:king, :diamonds)
    lower = Hand.new Card.new(:seven, :diamonds),
                     Card.new(:seven, :spades  ),
                     Card.new(:eight, :clubs   ),
                     Card.new(:ten, :clubs     ),
                     Card.new(:jack, :diamonds )
    assert(higher > lower)
  end

  def test_equal_pair_where_second_high_card_wins
    skip
    higher = Hand.new Card.new(:two, :hearts   ),
                      Card.new(:seven, :hearts ),
                      Card.new(:seven, :spades ),
                      Card.new(:jack, :spades  ),
                      Card.new(:king, :diamonds)
    lower = Hand.new Card.new(:seven, :diamonds),
                     Card.new(:seven, :clubs   ),
                     Card.new(:eight, :clubs   ),
                     Card.new(:ten, :clubs     ),
                     Card.new(:king, :hearts   )
    assert(higher > lower)
  end

  def test_equal_pair_where_high_card_third_high_card_wins
    skip
    higher = Hand.new Card.new(:three, :hearts ),
                      Card.new(:seven, :hearts ),
                      Card.new(:seven, :spades ),
                      Card.new(:jack, :spades  ),
                      Card.new(:king, :diamonds)
    lower = Hand.new Card.new(:seven, :diamonds),
                     Card.new(:seven, :clubs   ),
                     Card.new(:two, :clubs     ),
                     Card.new(:jack, :clubs    ),
                     Card.new(:king, :hearts   )
    assert(higher > lower)
  end

  def test_snafu_pair
    skip
    higher = Hand.new Card.new(:four, :hearts ),
                      Card.new(:two, :hearts ),
                      Card.new(:ace, :spades ),
                      Card.new(:three, :spades  ),
                      Card.new(:three, :diamonds)
    lower = Hand.new Card.new(:king, :diamonds),
                     Card.new(:queen, :clubs   ),
                     Card.new(:jack, :clubs     ),
                     Card.new(:three, :clubs    ),
                     Card.new(:three, :hearts   )
    assert(higher > lower)
  end

  def test_two_pair_is_two_pair
    skip
    hand = Hand.new Card.new(:two, :hearts   ),
                    Card.new(:seven, :hearts ),
                    Card.new(:seven, :spades ),
                    Card.new(:king, :spades  ),
                    Card.new(:king, :diamonds)
    assert_equal 'Two Pair', hand.name
  end

  def test_highest_pair_of_two_pair_wins
    skip
    higher = Hand.new Card.new(:four, :hearts ),
                      Card.new(:five, :hearts ),
                      Card.new(:five, :spades ),
                      Card.new(:ace, :spades  ),
                      Card.new(:ace, :diamonds)
    lower = Hand.new Card.new(:jack, :diamonds),
                     Card.new(:queen, :clubs  ),
                     Card.new(:queen, :clubs  ),
                     Card.new(:king, :clubs   ),
                     Card.new(:king, :hearts  )
    assert(higher > lower)
  end

  def test_higher_second_pair_wins_when_equal_first_pair
    skip
    higher = Hand.new Card.new(:two, :hearts  ),
                      Card.new(:jack, :hearts ),
                      Card.new(:jack, :spades ),
                      Card.new(:ace, :spades  ),
                      Card.new(:ace, :diamonds)
    lower = Hand.new Card.new(:jack, :diamonds),
                     Card.new(:ten, :clubs    ),
                     Card.new(:ten, :clubs    ),
                     Card.new(:ace, :clubs    ),
                     Card.new(:ace, :hearts   )
    assert(higher > lower)
  end

  def test_higher_card_wins_when_two_pair_equal
    skip
    higher = Hand.new Card.new(:ten, :hearts  ),
                      Card.new(:jack, :hearts ),
                      Card.new(:jack, :spades ),
                      Card.new(:ace, :spades  ),
                      Card.new(:ace, :diamonds)
    lower = Hand.new Card.new(:nine, :diamonds),
                     Card.new(:jack, :clubs   ),
                     Card.new(:jack, :clubs   ),
                     Card.new(:ace, :clubs    ),
                     Card.new(:ace, :hearts   )
    assert(higher > lower)
  end
  
  def test_trips_are_trips
    skip
    hand = Hand.new Card.new(:two, :hearts   ),
                    Card.new(:king, :hearts  ),
                    Card.new(:seven, :spades ),
                    Card.new(:king, :spades  ),
                    Card.new(:king, :diamonds)
    assert_equal 'Three of a Kind', hand.name
  end
end
