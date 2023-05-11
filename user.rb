class User

	START_BALANCE = 100
	attr_accessor :money, :used_cards

	def initialize
		@money = START_BALANCE
		@used_cards = []
	end

	def score
		total = 0
		@used_cards.each do |card|
			if card.card == 'A'
				total += joker_point(total, card.value)
			else
			  total += card.value
			end
		end
		total
	end

	def joker_point(total, card.value)
		if card.value + total <= 17
			joker_point = card.card.value
		else
			joker_point = 1
		end
		joker_point
	end
end



