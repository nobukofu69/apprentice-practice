require 'debug'

class Cpu < Player
  @@num_of_cpu = 0

  def initialize
    @@player_count += 1
    @@num_of_cpu += 1
    @name = "CPU#{@@num_of_cpu}"
    @cards = []
  end  

  def hit_or_stand(deck)
    puts "#{@name}の得点は#{score}です｡"
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

    puts "#{name}の得点は#{score}です。"
    # 得点に応じたメッセージを表示する
    if score > 21
      puts "#{@name}はバーストしました｡"
      @@player_count -= 1
    else
      puts "#{@name}はスタンドしました｡"
    end
  end
end