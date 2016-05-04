class ExtraCards

  def initalize
    @extra_cards = []
  end

  def <=> anOther
    value <=> anOther.value
  end

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
end