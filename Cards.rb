module Cards
  #Enum for cards
  #sends a deck to the dealer when asked
  #perhaps supply an optional arg for modifying the deck
  #attr_accessor :SUIT_VALUES, :FACE_VALUES

  SUIT_VALUES = {
    '♣' => 0,
    '♦' => 1,
    '♥' => 2,
    '♠' => 3
  }

  FACE_VALUES = {
    ' 2' => 2,
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
    ' A' => 14
  }

  SUITS = SUIT_VALUES.keys
  FACES = FACE_VALUES.keys

  def build_deck(number_of_cards)
    deck = []
    iterations = number_of_cards / 4

    SUITS.each do |suit|
      (0...iterations).each do |face|
        deck << (FACES[face] + suit)
      end
    end

    deck
  end

  def get_suit_value(suit)
    SUIT_VALUES[suit]
  end

  def get_face_value(face)
    FACE_VALUES[face]
  end
end
