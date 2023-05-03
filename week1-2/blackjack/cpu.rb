require 'debug'

class Cpu < Player
  @@num_of_cpu = 0

  def initialize
    @@player_count += 1
    @@num_of_cpu += 1
    @name = "CPU#{@@num_of_cpu}"
    @cards = []
    @money = 10_000
    @bet_size = 0
    @blackjack_flag = false
  end  

  # 手持ちの10%をベットする
  def set_bet_amount
    @bet_size = @money / 10
    @money -= @bet_size
  end

  # カードを引くかどうかを決める
  def hit_or_stand(deck)
    # ブラックジャックの場合､メソッドを抜ける
    return if @blackjack_flag
    puts "#{@name}の現在の得点は#{score}です｡"
    # 17点以上の場合､スタンドする
    if score >= 17
      puts "#{@name}はスタンドしました｡"
      return
    end

    # 17点未満の場合､ヒットし続ける
    while score < 17
      draw(deck)
      puts "#{@name}の引いたカードは#{@cards.last}です。"
    end

    # 21点を超えた場合､メソッドを抜ける
    return if score > 21

    # 17点以上の場合､スタンドする
    puts "#{@name}の得点は#{score}です｡"
    puts "#{@name}はスタンドしました｡"
  end
end