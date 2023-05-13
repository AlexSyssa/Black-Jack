# frozen_string_literal: true

class Deck
  attr_reader :cards

  SUITS = ['♥', '♦', '♣', '♠'].freeze

  def initialize
    @cards = []
    generate_deck.shuffle
  end

  def generate_deck
    SUITS.each do |suit|
      (2..9).each do |number|
        @cards << Card.new(suit, number)
      end
      %w[J Q K A].each do |name|
        @cards << Card.new(suit, name)
      end
    end
    cards.shuffle
  end
end
