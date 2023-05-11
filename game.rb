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
    deal
  end

  def deal
    @deck = Deck.new
    player.money -= BET
    dealer.money -= BET
    bank.money += BET * 2
    take_card(player)
    take_card(dealer)
  end

  def take_card(user)
    user.used_cards << @deck.cards.sample
  end

  def open_card
    player_score = player.score
    dealer_score = dealer.score

    spot_winner(player_score, dealer_score)
    if spot_winner == dealer_score
      puts 'Вы проиграли'
    else
      puts 'Поздравляем с победой!'
    end
  end

  def dealer_turn
    take_card(dealer) if dealer.score < 17
  end

  def deal_result
    player.used_cards.size == 3 || dealer.used_cards.size == 3
  end

  def open_cards
    player_score = player.score
    dealer_score = dealer.score
    count_money(player_score, dealer_score)
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
  end
end
