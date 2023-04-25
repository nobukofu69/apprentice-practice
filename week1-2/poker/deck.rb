require_relative 'card'

class Deck
  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::NUMBERS.each do |number|
        @cards << Card.new(suit, number)
      end
    end
    @cards.shuffle!
  end
  
  def draw
    @cards.pop
  end
end