require_relative './extra_cards.rb'

class Hand
  include Comparable

  attr_reader :cards, :extra_cards

  class << self
    def names
      [['High Card'       , 1..14 ],
       ['a Pair'          , 15..28],
       ['Two Pair'        , 113043054  ],
       ['Three of a Kind' , 210927012..1475899084],
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
    @extra_cards = ExtraCards.new
  end

  def <=> anOther
    return value <=> anOther.value unless value == anOther.value
    extra_value <=> anOther.extra_value
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
    #return three_of_a_kind if three_of_a_kind
    #return two_pair if two_pair
    return pair if pair
    high_card
  end

  def extra_value

  end

  private

  def face_values
    sorted_cards.map(&:face_value)
  end

  def face_value_counts
    face_values.each_with_object(Hash.new(0)) { |v, c| c[v] += 1 }
  end

  def delete_calculated_value(card)
      face_values.delete(card)
  end

  def high_card
    return face_values.max
  end

  def pair
    pair_and_count = face_value_counts.find { |_, v| v > 1 }
    return pair_plus_high_cards(face_value_counts, pair_and_count.first) if pair_and_count
  end

  def pair_plus_high_cards(face_value_counts, card)
    face_value_counts.delete(card)
    face_value_counts = face_value_counts.keys
    return highest_card_value(face_value_counts[2]) + second_highest_card_value(face_value_counts[1]) +
     third_highest_card_value(face_value_counts[0]) + pair_value(card) 
  end

  def two_pair
    pairs_and_count = face_value_counts.select { |_, v| v > 1 }
    if pairs_and_count.size > 1
      pair1 = pairs_and_count.shift
      pair2 = pairs_and_count.shift
      return two_pair_and_high_card(pair2[0], pair1[0], face_value_counts.keys)
    else
      return false
    end
  end

  def two_pair_and_high_card(high_pair, low_pair, high_card)
    high_card.delete(high_pair)
    high_card.delete(low_pair)
    return two_pair_value(high_pair) + pair_value(low_pair) + highest_card_value(high_card.first)
  end

  def three_of_a_kind
    trip = face_value_counts.select { |_, v| v > 2 }
    if trip.size > 0
      return three_of_a_kind_and_high_cards(trip, face_value_counts.keys)
    else
      return false
    end
  end

  def three_of_a_kind_and_high_cards(trip, high_cards)

  end

  

  def pair_value value
    value * 537824
  end

  def two_pair_value value 
    value * 7529536
  end
end
