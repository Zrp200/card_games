require_relative './card'

class Deck
  def initialize
    @cards = Card::Suits.flat_map { |suit| Card::Faces.map { |face| Card.new face, suit } }
    @cards.shuffle! # Might as well shuffle it here
  end

  def deal count, *players
    count.times { players.each { |player| deal_one_to player } }
  end

  private

  def deal_one_to player
    return unless card = @cards.shift
    player.hand << card
  end
end
