require_relative '../test_helper.rb'
require_relative '../../lib/texas_holdem/card'
require_relative '../../lib/texas_holdem/hand'

class HandTest < Minitest::Test
  def test_high_card_is_high_card
    cards = [
      Card.new(' 2', '♥'),
      Card.new(' 7', '♥'),
      Card.new(' 8', '♠'),
      Card.new('10', '♠'),
      Card.new(' K', '♦')
    ]
    hand = Hand.new *cards
    assert_equal 'High Card', hand.name
  end

  def test_higher_card_wins
    higher = Hand.new Card.new(' 2', '♥'),
                      Card.new(' 7', '♥'),
                      Card.new(' 8', '♠'),
                      Card.new('10', '♠'),
                      Card.new(' K', '♦')
    lower = Hand.new Card.new(' 2', '♦'),
                     Card.new(' 7', '♠'),
                     Card.new(' 8', '♣'),
                     Card.new('10', '♣'),
                     Card.new(' J', '♦')
    assert(higher > lower)
  end

  def test_pair_is_pair
    cards = [
      Card.new(' 2', '♥'),
      Card.new(' 7', '♥'),
      Card.new(' 7', '♠'),
      Card.new('10', '♠'),
      Card.new(' K', '♦')
    ]
    hand = Hand.new *cards
    assert_equal 'a Pair', hand.name
  end

  def test_higher_pair_wins
    higher = Hand.new Card.new(' 2', '♥'),
                      Card.new(' 7', '♥'),
                      Card.new(' 7', '♠'),
                      Card.new('10', '♠'),
                      Card.new(' K', '♦')
    lower = Hand.new Card.new(' 2', '♦'),
                     Card.new(' 2', '♠'),
                     Card.new(' 8', '♣'),
                     Card.new('10', '♣'),
                     Card.new(' J', '♦')
    assert(higher > lower)
  end

  def test_equal_pair_with_higher_card_wins
    skip
  end

  def test_equal_pair_with_equal_high_card_second_high_card_wins
    skip
  end
end
