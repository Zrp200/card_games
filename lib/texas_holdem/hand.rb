require_relative './extra_cards.rb'

class Hand
  include Comparable

  attr_reader :cards, :extra_cards

  class << self
    def names
      [['High Card'       , 2..14 ],
       ['a Pair'          , 15..27],
       ['Two Pair'        , 28..40],
       ['Three of a Kind' , 41..53],
       ['a Straight'      , 54..63],
       ['a Flush'         , 64..73],
       ['a Full House'    , 74..86],
       ['Four of a Kind'  , 87..99],
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
    return quads if quads
    return full_house if full_house
    return flush if flush
    return straight if straight
    return trips if trips
    return two_pair if two_pair
    return pair if pair
    high_card
  end

  def extra_value

  end

  private

  def high_card
    return face_values.max
  end

  def pair
    pair = face_value_counts.find { |_,count| count == 2 }
    return pair[0] + 13 if pair
  end

  def two_pair
    two_pair = face_value_counts.select { |_,count| count == 2 }
    return two_pair.keys.max + 26 if two_pair.size > 1
  end

  def trips
    trips = face_value_counts.select { |_,count| count == 3 }
    return trips.keys[0] + 39 if trips.size > 0
  end

  def straight
    return face_values.max + 49 if face_values.each_cons(2).all? { |x,y| y == x + 1 }
    return 54 if face_values == [2, 3, 4, 5, 14]
  end

  def flush
    return face_values.max + 59 if suit_values.uniq.size == 1
  end

  def full_house
    multiples = face_value_counts.select { |_, count| count >= 2 }
    return multiples.find { |card, count| count == 3 }[0] + 72 if multiples.values.include?(3)
  end

  def quads
    quad = face_value_counts.select { |_, count| count == 4 }
    return quad.keys[0] + 85 if quad.size > 0
  end

  def straight_flush

  end

  def face_values
    sorted_cards.map(&:face_value)
  end

  def suit_values
    sorted_cards.map(&:suit_value)
  end

  def face_value_counts
    face_values.each_with_object(Hash.new(0)) { |v, c| c[v] += 1 }
  end

  def get_multiples(number)

  end

  
end
