class Hand
  attr_reader :cards

  def initialize *cards
    @cards = cards
  end

  def << card
    cards << card
  end

  def combined_with hand
    combined_cards = cards + hand.cards
    self.class.new *combined_cards
  end

  def sorted_cards
    cards.sort_by(&:face_value)
  end

  def to_s
    "#{cards.map(&:to_s)}"
  end
end
