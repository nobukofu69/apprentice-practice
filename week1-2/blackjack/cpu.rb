require 'debug'

class Cpu < Player
  @@num_of_cpu = 0

  def initialize
    @@player_count += 1
    @@num_of_cpu += 1
    @name = "CPU#{@@num_of_cpu}"
    @cards = []
  end  

  # カードを引くかどうかを決める
  def hit_or_stand(deck)
    # ブラックジャックの場合､メソッドを抜ける
    return if @black_jack_flag

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

  # バーストしているか確認し､バーストしていたらプレイヤーの人数を減らす
  def check_burst
    if score > 21
      puts "#{name}の得点は#{score}です。"
      puts "#{name}はバーストしました"
      @@player_count -= 1
    end
  end
end