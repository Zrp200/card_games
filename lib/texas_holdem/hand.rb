class Hand
  include Comparable

  attr_reader :cards

  class << self
    def names
      [['High Card'       , 111110..111170  ],
       ['a Pair'          , 1111008..1111056],
       ['Two Pair'        , 9999999999],
       ['Three of a Kind' , 9999999999],
       ['a Straight'      , 9999999999],
       ['a Flush'         , 9999999999],
       ['a Full House'    , 9999999999],
       ['Four of a Kind'  , 9999999999],
       ['a Straight Flush', 9999999999],
       ['a Royal Flush'   , 9999999999]]
    end
  end

  def initialize *cards
    @cards = cards
  end

  def <=> anOther
    value <=> anOther.value
  end

  def << card
    cards << card
  end

  def combined_with hand
    combined_cards = cards + hand.cards
    self.class.new(*combined_cards)
  end

  def name
    value_pair = self.class.names.find { |_, range| range === value }
    return unless value_pair
    value_pair.first
  end

  def sorted_cards
    cards.sort_by(&:face_value)
  end

  def to_s
    "#{cards.map(&:to_s)}"
  end

  protected

  def value
    return pair if pair
    high_card
  end

  private

  def face_values
    cards.map(&:face_value)
  end

  def face_value_counts
    face_values.each_with_object(Hash.new(0)) { |v, c| c[v] += 1 }
  end

  def high_card
    values = face_values
    values[0] + (values[1] +100) + third_highest_card(values[2]) + second_highest_card(values[3]) + highest_card(values[4])
  end

  def highest_card(value)
    value + 100000
  end

  def second_highest_card(value)
    value + 10000    
  end

  def third_highest_card(value)
    value + 1000
  end

  def pair
    pair_and_count = face_value_counts.find { |_, v| v > 1 }
    return pair_plus_high_cards(face_value_counts, pair_and_count.first) if pair_and_count
  end

  def pair_plus_high_cards(face_value_counts, card)
    high_cards = face_values.delete(card)
    return highest_card(face_value_counts[2]) + second_highest_card(face_value_counts[1]) + third_highest_card(face_value_counts[1]) + card + 1000000
  end
end
