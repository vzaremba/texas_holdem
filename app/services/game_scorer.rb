class GameScorer
  attr_reader :winning_hand

  HAND_COMBINATIONS = Hash[%i[high_card one_pair two_pair three_of_a_kind straight flush].zip((1..6).to_a)]

  def initialize(game)
    @hands = game.hands
    @hands.each do |hand|
      hand.count_rank(game.deck.common_cards)
    end

    get_winning_hand
  end

  private def winning_hand_sort
    lambda do |a, b|
      hand_order = HAND_COMBINATIONS[a.rank] <=> HAND_COMBINATIONS[b.rank]
      hand_order = hand_order != 0 ? hand_order : a.highest_pair_value <=> b.highest_pair_value
      hand_order = hand_order != 0 ? hand_order : a.high_card.numeric_value <=> b.high_card.numeric_value
    end
  end

  private def ranked_hands
    @hands.sort(&winning_hand_sort)
  end

  private def get_winning_hand
    @winning_hand = ranked_hands.last
  end
end
