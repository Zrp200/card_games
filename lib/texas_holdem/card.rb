class Card
  attr_reader :face, :suit
  Faces = %i(two three four five six seven eight nine ten jack queen king)
  FaceDisplays = Hash[ Faces.zip %w(2 3 4 5 6 7 8 9 10 J Q K A) ]
  FaceValues = Hash[Faces.zip 2..14]
  Suits = %i(clubs diamonds hearts spades)
  SuitDisplays = Hash[ Suits.zip %w(♣ ♦ ♥ ♠) ]
  SuitValues = Hash[ Suits.zip 0..3]

  def initialize face, suit
    @face = face
    @suit = suit
  end

  def face_value
    FaceValues.fetch @face
  end

  def suit_value
    SuitValues.fetch @suit
  end

  def to_s
    "#{FaceDisplays.fetch @face}#{SuitDisplays @suit}"
  end
end
