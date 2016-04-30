class Card
  attr_reader :face, :suit

  def initialize face, suit
    @face = face
    @suit = suit
  end

  class << self
    def face_values
      { ' 2' => 2,
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
    end

    def suit_values
      { '♣' => 0,
        '♦' => 1,
        '♥' => 2,
        '♠' => 3 }
    end
  end

  def face_value
    self.class.face_values[face]
  end

  def suit_value
    self.class.suit_values[suit]
  end

  def to_s
    "#{face}#{suit}"
  end
end
