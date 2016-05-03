require_relative '../test_helper.rb'
require_relative '../../lib/texas_holdem/card'
require_relative '../../lib/texas_holdem/hand'

class HandTest < Minitest::Test
  def test_high_card_is_high_card
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

  def test_equal_pair_with_higher_card_wins
    skip
  end

  def test_equal_pair_with_equal_high_card_second_high_card_wins
    skip
  end
end
