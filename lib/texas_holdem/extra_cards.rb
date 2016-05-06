require_relative './extra_cards.rb'

class ExtraCards
  attr_accessor :cards

  def initalize *cards
    @cards = *cards
  end

  def <=> anOther
    @cards.reverse <=> anOther.cards.reverse
  end

  def << card
    @cards << card
  end
end