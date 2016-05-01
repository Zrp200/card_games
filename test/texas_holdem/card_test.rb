require_relative '../test_helper.rb'
require_relative '../../lib/texas_holdem/card'

class CardTest < Minitest::Test
  def test_face_value
    card = Card.new ' 2', '♣'
    assert_equal 2, card.face_value
  end

  def test_suit_value
    card = Card.new ' 2', '♣'
    assert_equal 0, card.suit_value
  end

  def test_to_string
    card = Card.new ' 2', '♣'
    assert_equal ' 2♣', card.to_s
  end
end
