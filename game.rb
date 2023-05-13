# frozen_string_literal: true

class Game
  attr_accessor :player, :dealer, :deck, :bank, :player_name

  BLACKJACK = 21
  BET = 10

  def initialize(player_name)
    @player_name = player_name
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @bank = Bank.new
  end

  def deal
    @deck = Deck.new
    player.money -= BET
    dealer.money -= BET
    bank.money += BET * 2
    2.times { take_card(player) }
    2.times { take_card(dealer) }
  end

  def take_card(user)
    if @bank.money >= 10
      user.used_cards << @deck.cards.sample
    else
      puts "Вы не можете сделать ставку, ваш баланс #{player.money}."
    end
  end

  def open_card
    player_score = player.score
    dealer_score = dealer.score
    spot_winner(player_score, dealer_score)
  end

  def dealer_turn
    if dealer.score >= 17
      puts 'Дилер пропускает ход.'
    else
      take_card(dealer)
    end
  end

  def deal_result
    player.used_cards.size == 3 || dealer.used_cards.size == 3
  end

  def open_cards
    player_score = player.score
    dealer_score = dealer.score
    count_money(player_score, dealer_score)
    who_win(player_score, dealer_score)
  end

  def spot_winner(player_score, dealer_score)
    # Если сума очков одинаковая, то обьявляется ничья
    # Если игрок набрал очков больше 21 - он проиграл.
    # Победа за тем, у кого сумма очков ближе к 21

    return if dealer_score == player_score
    return if dealer_score > BLACKJACK && player_score > BLACKJACK
    return player if dealer_score > BLACKJACK
    return dealer if player_score > BLACKJACK

    dealer_score > player_score ? dealer : player
  end

  def count_money(player_score, dealer_score)
    winner = spot_winner(player_score, dealer_score)
    if winner
      winner.money += bank.money
    else
      player.money += bank.money / 2
      dealer.money += bank.money / 2
    end
    @bank.money = 0
  end

  def who_win(player_score, dealer_score)
    winner = spot_winner(player_score, dealer_score)
    if winner == player
      puts "#{player_name}, вы победили!"
    elsif winner == dealer
      puts 'Победа за Дилером! Вы проиграли.'
    else
      puts 'Победителя нет.'
    end
    puts '*' * 70
  end
end
