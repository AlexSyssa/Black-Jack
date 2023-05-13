# frozen_string_literal: true

class Gamer
  START_BALANCE = 100
  attr_accessor :money, :used_cards, :name

  def initialize
    @name = name
    @money = START_BALANCE
    @used_cards = []
    @points = []
  end

  def score
    points = []
    @used_cards.each do |card|
      points << if points.sum + card.value > 21 && (points.include?(11) || card.value == 11)
                  card.value - 10
                else
                  card.value
                end
    end
    points.sum
  end
end
