class Player
  attr_reader :name, :cards
  
  def initialize(name)
    @name = name
    @cards = []
  end

  def draw(deck, number)
    number.times do
      @cards << deck.draw
    end
  end
end