require 'debug'
require_relative 'deck'

class Player
  def initialize(name)
    @name = name
    @cards = []
  end

  def draw(deck)
    @cards << deck.draw
  end
end