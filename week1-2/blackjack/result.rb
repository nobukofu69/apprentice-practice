require 'debug'

class Result
  def initialize(dealer, players)
    @dealer = dealer
    @players = players
  end

  def judge
    puts '結果発表！' 
    @players.each do |player|
      # プレーヤーがバーストしていた場合､次のプレーヤーの判定へ
      next if player.score > 21

      # ブラックジャックフラグが立っている場合の処理
      if player.black_jack_flag && @dealer.black_jack_flag
        puts "#{player.name}は引き分けです｡"
        next
      elsif player.black_jack_flag 
        puts "#{player.name}の勝ちです！"
        next
      elsif @dealer.black_jack_flag
        puts "#{player.name}の負けです｡"
        next
      end

      # ブラックジャックフラグがない場合の処理
      if @dealer.score > 21 || player.score > @dealer.score
        puts "#{player.name}の勝ちです！"
      elsif player.score < @dealer.score
        puts "#{player.name}の負けです｡"
      else 
        puts "#{player.name}は引き分けです｡"
        next
      end
    end
  end
end

