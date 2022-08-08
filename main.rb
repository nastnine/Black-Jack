class Interface
  attr_accessor :player, :dealer, :bank, :deck

  def initialize
    print 'Введите свое имя:'
    @player = Player.new(gets.chomp.capitalize)
    @dealer = Player.new('Dealer')
    @bank = 0
    start
  end

  def start
    print 'Добро пожаловать в игру "Black Jack"!'
    @player.zero_out
    @dealer.zero_out
    @deck = Deck.new
    @deck.shuffle_cards!
    2.times do
      @player.draw_a_card(@deck)
      @dealer.draw_a_card(@deck)
    end
    @player.make_bet
    @dealer.make_bet
    @bank = 20
    option_game
  end

  def option_game
    show_cards
    puts 'Введите:(1)пропустить ход, (2)добавить карту, (3)открыть карты'
    action = gets.chomp.to_i
    case action
    when 1
      skip_move
      open_cards
    when 2
      @player.draw_a_card(@deck)
      dealer_move
      open_cards
    when 3
      open_cards
    end
  rescue TypeError
    puts 'Введите корректное значение'
  end

  def show_cards
    user_cards
    puts "Карты Dealer: 'XX'"
  end

  def user_cards
    @player.each { |card| print "#{card.suit} #{card.picture}" }
    puts "Ваши очки: #{@player.card_points}"
  end

  def dealer_cards
    @dealer.each { |card| print "#{card.suit} #{card.picture}" }
    puts "Количество очков Dealer: #{@dealer.card_points}"
  end

  def skip_move
    dealer_move
  end

  def dealer_move
    @dealer.add_card(desk) if @dealer.card_points < 17
  end

  def open_cards
    puts 'Открываем карты...'
    user_cards
    dealer_cards
    calculation_results
    new_round
  end

  def calculation_results
    if (@player.card_points > @dealer.card_points) && @player.card_points <= 21
      user_winner
    elsif @player.card_points == @dealer.card_points
      draw_game
    else
      dealer_winner
    end
  end

  def user_winner
    @player.money += @bank
    puts 'Вы победили!'
  end

  def dealer_winner
    @dealer.money += @bank
    puts 'Dealer выиграл!'
  end

  def draw_game
    @player.money += @bank / 2
    @dealer.money += @bank / 2
    puts 'Ничья!'
  end

  def new_round
    puts 'Хотите сыграть еще раз? (1)Да, (2)Нет'
    case gets.chomp.to_i
    when 1
      start
    when 2
      exit
    end
  end

  def exit
    puts 'Игра закончена!'
  end
end
