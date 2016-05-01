require_relative './card'

module Deck
  extend self

  def deck
    suits.flat_map { |suit| faces.map { |face| Card.new face, suit } }
  end

  private

  def faces
    Card.face_values.keys
  end

  def suits
    Card.suit_values.keys
  end
end
