require_relative '../test_helper.rb'
require_relative '../../lib/texas_holdem/card'

class CardTest < Minitest::Test
  def test_all_face_values
    expected = { ' 2' => 2,
                 ' 3' => 3,
                 ' 4' => 4,
                 ' 5' => 5,
                 ' 6' => 6,
                 ' 7' => 7,
                 ' 8' => 8,
                 ' 9' => 9,
                 '10' => 10,
                 ' J' => 11,
                 ' Q' => 12,
                 ' K' => 13,
                 ' A' => 14 }
    assert_equal expected, Card.face_values
  end

  def test_all_suit_values
    expected = { '♣' => 0,
                 '♦' => 1,
                 '♥' => 2,
                 '♠' => 3 }
    assert_equal expected, Card.suit_values
  end

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
