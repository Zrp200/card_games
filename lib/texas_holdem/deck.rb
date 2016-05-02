class Deck
  class << self
    def face_values
      { ' 2' => 2,
        ' 3' => 3,
        ' 4' => 4,
        ' 5' => 5,
        ' 6' => 6,
        ' 7' => 7,
        ' 8' => 8,
        ' 9' => 9,
        '10' => 10,
        ' J' => 11,
        ' Q' => 12,
        ' K' => 13,
        ' A' => 14 }
    end

    def suit_values
      { '♣' => 0,
        '♦' => 1,
        '♥' => 2,
        '♠' => 3 }
    end
  end

  def initialize
    @cards = new_deck
  end

  def deal count, *players
    count.times { players.each { |player| deal_one_to player } }
  end

  private

  def deal_one_to player
    return unless card = @cards.sample
    player.hand << card
    @cards.delete card
  end

  def faces
    self.class.face_values.keys
  end

  def new_deck
    suits.flat_map { |suit| faces.map { |face| Card.new face, suit } }
  end

  def suits
    self.class.suit_values.keys
  end
end
