require 'debug'

class Hand
  def hand(cards)
    scores = []
    cards.each do |card|
      scores << case card.number
                when 'J','Q','K' then 10
                when 'A' then 11
                else card.number.to_i
                end
    end
    scores.inject(:+) # これで合計値が出る
  end
end