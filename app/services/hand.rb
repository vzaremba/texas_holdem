class Hand
  attr_accessor :cards, :id, :pairs, :all_cards, :rank

  def initialize(id = 0)
    @id        = id
    @cards     = []
    @all_cards = []
  end

  def draw(cards)
    @cards = cards
  end

  def count_rank(common_cards)
    @all_cards = @cards + common_cards
    @rank = get_combination
  end

  def high_card
    @cards.sort! { |a, b| a.numeric_value <=> b.numeric_value }.last
  end

  def highest_pair_value
    @pairs.keys.map {|k| Card.all_faces[k]}.max
  end

  private def sort_cards!
    @all_cards.sort! { |a, b| a.numeric_value <=> b.numeric_value }
  end

  private def get_combination
    sort_cards!
    return :flush           if flush?
    return :straight        if straight?
    find_pairs
    return :three_of_a_kind if three_of_a_kind?
    return :two_pair        if two_pair?
    return :one_pair        if pair?
    :high_card
  end

  private def flush?
    card_suits.select { |item| card_suits.count(item) > 4 }.uniq.length == 1
  end

  private def card_suits
    @all_cards.map { |card| card.suit }
  end

  private def straight?
    consecutive_card_count > 4
  end

  private def consecutive_card_count
    consecutive_count = 1

    if @all_cards.last.face == :ace && @all_cards.first.face == :two
      consecutive_count += 1
    end

    @all_cards.each_cons(2) do |card, next_card|
      unless consecutive_count > 4
        consecutive_cards?(card, next_card) ? consecutive_count += 1 : consecutive_count = 1
      end
    end
    consecutive_count
  end

  private def consecutive_cards?(card, next_card)
    card.numeric_value.succ == next_card.numeric_value
  end

  private def find_pairs
    @pairs = Hash.new(0)
    @all_cards.each { |c| @pairs[c.face] += 1 }
    @pairs.select! { |k,v| v > 1 }
  end

  private def pair?
    @pairs.any? { |k, count| count > 1 }
  end

  private def three_of_a_kind?
    @pairs.any? { |k, count| count > 2 }
  end

  private def two_pair?
    pairs_counted = @pairs.count { |_, pair| pair > 1 }
    pairs_counted > 1
  end
end
