require_relative './deck'

class Card
  attr_reader :face, :suit

  def initialize face, suit
    @face = face
    @suit = suit
  end

  def face_value
    Deck.face_values[face]
  end

  def suit_value
    Deck.suit_values[suit]
  end

  def to_s
    "#{face}#{suit}"
  end
end
