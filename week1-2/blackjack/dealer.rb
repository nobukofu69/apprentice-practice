require 'debug'
require_relative 'deck'
require_relative 'hand'

class Dealer < Player
  def initialize(name)
    @name = name
    @cards = []
  end

  def hit_or_stand(deck)
    # 17点以上の場合､スタンドする
    return if score >= 17

    puts "#{@name}の現在の得点は#{score}です。"
    # 17点未満の場合､ヒットする
    while score < 17
      draw(deck)
      puts "#{@name}の引いたカードは#{@cards.last}です。"
    end
    if score > 21
      puts "バーストしました｡"
    end
  end
end