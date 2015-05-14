class Deck
  attr_reader :cards, :common_cards

  def initialize()
    build_deck
    @cards.shuffle!
  end

  def deal(amount)
    @cards.pop(amount)
  end

  def deal_to(hand)
    hand.draw(deal(2))
  end

  def deal_common_cards
    @common_cards = deal(5)
  end

  private def build_deck
    @cards = []
    Card.all_faces.keys.each do |face|
      Card.all_suits.each { |suit| @cards << Card.new(face, suit) }
    end
  end
end
