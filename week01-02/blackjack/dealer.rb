require 'debug'

class Dealer < Player
  def initialize(name)
    @name = name
    @cards = []
    @blackjack_flag = false
  end

  # ディールする
  def deal(deck)
    draw(deck, 2)
    puts "#{@name}の引いた1枚目のカードは#{@cards[0]}です。"
    puts "#{@name}の引いた2枚目のカードはわかりません。"
  end

  # 17点以上になるまでヒットし続ける
  def auto_hit(deck)
    # ブラックジャックの場合､メソッドを抜ける
    return if @blackjack_flag
    
    puts "#{@name}の得点は#{score}です。"
    # 17点以上の場合､メソッドを抜ける
    return if score >= 17

    # 17点未満の場合､ヒットし続ける
    while score < 17
      draw(deck)
      puts "#{@name}の引いたカードは#{@cards.last}です。"
    end

    # ループを抜けた時点の得点に応じて処理を行う
    if score > 21
      return display_burst
    else
      puts "#{@name}の得点は#{score}です｡"
    end
  end

  # バーストしていた場合､メッセージを表示する
  def display_burst
    puts "#{@name}の得点は#{score}です。"
    puts "#{@name}はバーストしました｡"
  end
end