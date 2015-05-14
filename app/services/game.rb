class Game
  attr_reader :deck, :hands, :players

  PLAYERS = %w(PlayerA PlayerB).freeze
  private_constant :PLAYERS

  def initialize()
    initialize_players
    initialize_hands
    @deck = Deck.new
  end

  def start
    @hands.each { |hand| deck.deal_to hand }
    deck.deal_common_cards
  end

  private def initialize_players
    @players = {}
    PLAYERS.each_with_index { |player, index| @players[index] = player }
  end

  private def initialize_hands
    @hands = []
    @players.keys.each { |player| @hands << Hand.new(player) }
  end
end
