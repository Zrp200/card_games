class Hand
  attr_reader :cards

  def initialize *cards
    @cards = cards
  end

  def << card
    cards << card
    cards.sort_by(&:face_value)
  end
  alias_method :push, :<<

  def to_s
    "#{cards.map(&:to_s)}"
  end
end
