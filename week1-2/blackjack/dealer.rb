require 'debug'

class Dealer < Player
  def initialize(name)
    @name = name
    @cards = []
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
    return if @black_jack_flag
    
    puts "#{@name}の得点は#{score}です。"
    # 17点以上の場合､メソッドを抜ける
    return if score >= 17

    # 17点未満の場合､ヒットし続ける
    while score < 17
      draw(deck)
      puts "#{@name}の引いたカードは#{@cards.last}です。"
    end

    # ループを抜けた時点で21点以下の場合､メッセージを表示する
    puts "#{@name}の得点は#{score}です｡" if score <= 21
  end

  # バーストしていた場合､メッセージを表示する
  def check_burst
    if score > 21
      puts "#{name}の得点は#{score}です。"
      puts "#{name}はバーストしました"
    end
  end
end