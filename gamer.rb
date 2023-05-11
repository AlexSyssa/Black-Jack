# frozen_string_literal: true

class Gamer
  START_BALANCE = 100
  attr_accessor :money, :used_cards, :name

  def initialize
    @name = name
    @money = START_BALANCE
    @used_cards = []
  end

  def take_card(card)
    @used_cards << card
    @scope = count_points
  end

  def score
    total = 0
    @used_cards.each do |card|
      total += if card.card == 'A'
                 joker_point(total, card.value)
               else
                 card.value
               end
    end
    total
  end

  def joker_point(total, value)
    if value + total <= 17
      value
    else
      1
    end
  end

  def reset
    @used_cards.clear
  end
end
