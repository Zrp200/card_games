require_relative './card'

module Cards
  extend self

  def build_deck(number_of_cards)
    deck = []
    iterations = number_of_cards / 4
    suits.each do |suit|
      (0...iterations).each do |face|
        deck << Card.new(faces[face], suit)
      end
    end
    deck
  end

  private

  def faces
    Card.face_values.keys
  end

  def suits
    Card.suit_values.keys
  end
end
