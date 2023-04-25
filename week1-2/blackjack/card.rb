require 'debug'

class Card  
  SUITS = %w(スペード ハート ダイヤ クローバー)
  NUMBERS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)

attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  def to_s
    "#{@suit}の#{@number}"
  end
end