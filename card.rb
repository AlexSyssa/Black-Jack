# frozen_string_literal: true

class Card
  attr_accessor :suit, :value, :card

  def initialize(suit, card)
    @suit = suit
    @card = card
    @value = card_value
  end

  def show_card
    "#{card} - #{value}"
  end

  def card_value
    return 10 if %w[J Q K].include?(@card)
    return 11 if @card == 'A'

    @card
  end
end
