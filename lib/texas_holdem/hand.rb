class Hand
  include Comparable

  attr_reader :cards

  class << self
    def names
      [['High Card'       ,      2..    14],
       ['a Pair'          ,     20..   140],
       ['Two Pair'        ,    153..   274],
       ['Three of a Kind' ,    300..  1500],
       ['a Straight'      ,   2000..  5600],
       ['a Flush'         ,   5800        ],
       ['a Full House'    ,   6030.. 30130],
       ['Four of a Kind'  ,  40000..160000],
       ['a Straight Flush', 170000..173200],
       ['a Royal Flush'   , 173600        ]]
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
    self.class.new *combined_cards
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
    return pair * 10 if pair
    face_values.max
  end

  private

  def face_values
    cards.map(&:face_value)
  end

  def face_value_counts
    face_values.each_with_object(Hash.new(0)) { |v, c| c[v] += 1 }
  end

  def pair
    pair_and_count = face_value_counts.find { |_, v| v > 1 }
    pair_and_count && pair_and_count.first
  end
end
