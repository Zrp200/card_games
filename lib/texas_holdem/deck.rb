require_relative './card'

class Deck
  def initialize
    @cards = new_deck
  end

  def deal count, *players
    count.times { players.each { |player| deal_one_to player } }
  end

  private

  def deal_one_to player
    return unless card = @cards.sample
    player.hand << card
    @cards.delete card
  end

  def faces
    Card.face_values.keys
  end

  def new_deck
    suits.flat_map { |suit| faces.map { |face| Card.new face, suit } }
  end

  def suits
    Card.suit_values.keys
  end
end
