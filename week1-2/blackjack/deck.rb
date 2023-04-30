require 'debug'
require_relative 'card'

class Deck
  def initialize
    @cards = []
    Card::SUIT.each do |suit|
      Card::NUMBER.each do |i|
        @cards << Card.new(suit, i)
      end
    end
    @cards.shuffle!
  end

  def draw
    @cards.shift
  end
end