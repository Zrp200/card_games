class Hand
  attr_reader :cards

  def initialize *cards
    @cards = cards
  end

  def << card
    cards << card
  end
  alias_method :push, :<<

  def sorted_cards
    cards.sort_by(&:face_value)
  end

  def to_s
    "#{cards.map(&:to_s)}"
  end
end
