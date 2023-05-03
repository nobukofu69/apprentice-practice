require 'debug'

class Dealer < Player
  def initialize(name)
    @name = name
    @cards = []
  end

  # ディールする
  def deal(deck)
    draw(deck, 2)
    puts "#{@name}の引いたカードは#{@cards[0]}です。"
    puts "#{@name}の引いた2枚目のカードはわかりません。"
  end

  # カードを引くかどうかを決める
  def hit_or_stand(deck)

    # 17点以上の場合､スタンドする
    if score >= 17
      puts "#{@name}の得点は#{score}です｡"
      puts "#{@name}はスタンドしました｡"
      return
    end

    # 17点未満の場合､ヒットし続ける
    puts "#{@name}の現在の得点は#{score}です。"
    while score < 17
      draw(deck)
      puts "#{@name}の引いたカードは#{@cards.last}です。"
    end
    
    puts "#{name}の得点は#{score}です。"
    # 21点を超えた場合､バーストする
    if score > 21
      puts "#{@name}はバーストしました｡"
    end
  end
end