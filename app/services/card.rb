class Card
  attr_reader :face, :suit

  SUITS = %i[club spade diamond heart]
  FACES = Hash[%i[two three four five six seven eight nine ten jack queen king ace].zip((2..14).to_a)]

  def initialize(face, suit)
    @face = face
    @suit = suit
  end

  def numeric_value
    FACES[face]
  end

  def to_s
    @face.to_s.capitalize << " of " << @suit.to_s.capitalize.pluralize
  end

  def self.all_suits
    SUITS
  end

  def self.all_faces
    FACES
  end
end
