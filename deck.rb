require_relative 'card'

class Deck
  SUITS = %w[♥ ♦ ♣ ♠].freeze
  PICTURES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :cards

  def initialize
    @cards = []
    SUITS.each do |suit|
      PICTURES.each do |picture|
        @cards << Card.new(suit, picture)
      end
    end
  end

  def shuffle_cards
    @cards.shuffle!
  end

  def draw_a_card
    @cards.pop
  end
end
