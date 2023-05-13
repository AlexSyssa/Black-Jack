# frozen_string_literal: true

class Interface
  attr_accessor :game, :player_name

  MENU = [
    { id: 0, title: 'Выйти из игры', action: :exit },
    { id: 1, title: 'Добавить карту', action: :take_card },
    { id: 2, title: 'Пропустить', action: :miss },
    { id: 3, title: 'Открыть карты', action: :deal_cycle }
  ].freeze

  BLACKJACK = 21
  BET = 10

  def initialize
    @game = game
    @player_name = player_name
  end

  def start_menu
    puts ''
    puts ''
    MENU.each do |item|
      puts "#{item[:id]} - #{item[:title]}"
    end
  end

  def program
    loop do
      start_menu
      puts 'Выберите действие и введите соответствующую цифру:'
      choice = gets.chomp.to_i
      break if choice.zero?

      puts
      send(MENU[choice][:action])
    end
  end

  def start
    welcome
    puts 'Вы желаете начать игру? 1 - да, 0 - нет'
    answer = gets.chomp
    case answer
    when '1'
      next_round
    when '0'
      'До скорой встречи!'
    end
  end

  def welcome
    puts 'Игра Black Jack'
    puts
    puts 'Введите ваше имя'
    @player_name = gets.strip
    @game = Game.new(player_name)
    puts "У Вас в банке - #{game.player.money}$"
    puts "Размер одной ставки - #{BET}$"
    puts "Удачи, #{player_name}"
    puts '*' * 70
  end

  def miss
    game.dealer_turn
    deal_cycle
  end

  def take_card
    game.take_card(game.player)
    game.dealer_turn
    game.deal_result ? deal_cycle : show_cards
  end

  def next_round
    game.player.used_cards = []
    game.dealer.used_cards = []
    puts "У Вас в банке #{game.player.money}$"
    puts 'Раздача карт:'
    puts
    game.deal
    show_cards
    program
  end

  def deal_cycle
    show_cards_when_open
    game.open_cards
    show_players_money(game.player, game.dealer)
    continue?
  end

  def show_player_cards(player, value = nil)
    puts "#{player.name}, у вас на руках (#{value} points): "
  end

  def hidden_dealer_card(amount)
    print '* ' * amount
  end

  def show_dealer_cards(value = nil)
    if value
      puts "Dealer cards (#{value} points): "
    else
      puts 'Dealer cards: '
    end
  end

  def show_cards
    show_player_cards(game.player, game.player.score)
    game.player.used_cards.each { |card| puts "#{card.card} #{card.suit}" }
    puts
    show_dealer_cards
    hidden_dealer_card(game.dealer.used_cards.size)
    puts
  end

  def show_cards_when_open
    show_player_cards(game.player, game.player.score)
    game.player.used_cards.each { |card| puts "#{card.card} #{card.suit}" }
    puts
    show_dealer_cards(game.dealer.score)
    game.dealer.used_cards.each { |card| puts "#{card.card} #{card.suit}" }
    puts
  end

  def show_players_money(player, dealer)
    puts "#{player.name} money: #{player.money}"
    puts "Dealer money: #{dealer.money}"
  end

  def continue?
    puts 'Вы желаете продолжить игру? 1 - да, 0 - нет'
    answer = gets.chomp
    case answer
    when '1'
      next_round
    when '0'
      puts "До скорой встречи. Ваш результат на сегодня #{game.player.money - 100}"
    end
  end

  def exit
    "До скорой встречи. Ваш результат на сегодня #{game.player.money - 100}"
  end
end
