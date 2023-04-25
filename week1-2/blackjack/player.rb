require 'debug'

class Player
  attr_reader :name, :cards

  def initialize(name, hand)
    @name = name
    @cards = []
    @hand = hand
  end

  def draw(deck, number)
    number.times do
      @cards << deck.draw
    end
  end 

  def hand
    @hand.hand(@cards)
  end
end