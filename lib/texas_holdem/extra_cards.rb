class ExtraCards

  def initalize
    @extra_cards = []
  end

  def <=> anOther
    value <=> anOther.value
  end

  #Think of better way to do below, like comparing arrays value by value until a larger

  def value
    if extra_cards.length == 4
      return four_cards
    elsif extra_cards.length == 3
      return three_cards
    elsif extra_cards.length == 2
      return two_cards
    elsif extra_cards.length == 1
      return one_card
    else
      0
    end
  end

  def one_card
  	return highest_card_value(extra_cards[0])
  end

  def two_cards
    return highest_card_value(extra_cards[1]) + second_highest_card_value(extra_cards[0])
  end

  def three_cards
    return highest_card_value(extra_cards[2]) + second_highest_card_value(extra_cards[1]) +
  	  third_highest_card_value(extra_cards[0])
  end

  def four_cards
  	return highest_card_value(extra_cards[3]) + second_highest_card_value(extra_cards[2]) +
  	  third_highest_card_value(extra_cards[1]) + fourth_highest_card_value(extra_cards[0])
  end
  
  def fourth_highest_card_value value
  	value * 14
  end

  def third_highest_card_value value 
    value * 196
  end

  def second_highest_card_value value 
    value * 2744    
  end

  def highest_card_value value 
    value * 38416
  end

  def pair_old
    pair_and_count = face_value_counts.find { |_, v| v > 1 }
    return pair_plus_high_cards(face_value_counts, pair_and_count.first) if pair_and_count
  end

  def pair_plus_high_cards(face_value_counts, card)
    face_value_counts.delete(card)
    face_value_counts = face_value_counts.keys
    return highest_card_value(face_value_counts[2]) + second_highest_card_value(face_value_counts[1]) +
     third_highest_card_value(face_value_counts[0]) + pair_value(card) 
  end

  def two_pair_old
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