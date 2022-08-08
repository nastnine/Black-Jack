class Player
  attr_reader :name, :money, :cards

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
  end

  def add_card(deck)
    validate!
    @cards << deck.draw_a_card
  end

  def zero_out
    @cards = []
  end

  def make_bet
    @money -= 10
  end

  def validate!
    raise 'Вы не можете взять карту' if @card.size == 3
  end

  def card_points
    points = 0
    cards.each do |card|
      points += if %w[J Q K].include?(card.picture)
                  10
                elsif card.picture == 'A' && points <= 10
                  11
                elsif card.picture == 'A'
                  1
                else
                  card.picture.to_i
                end
    end
    points
  end
end
