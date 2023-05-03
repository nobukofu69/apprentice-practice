require 'debug'

class Result
  def initialize(dealer, *players)
    @dealer = dealer
    @players = players
  end

  def judge
    @players.each do |player|
      # プレーヤーがバーストしていた場合､次のプレーヤーの判定へ
      next if player.score > 21
      puts "#{player.name}の得点は#{player.score}です。"
      # ディーラーがバースト､またはプレーヤーの得点がディーラーを上回っている場合
      if @dealer.score > 21 || player.score > @dealer.score
        puts "#{player.name}の勝ちです！"
      elsif player.score < @dealer.score
        puts "#{player.name}の負けです｡"
      else # 同点の場合
        puts "#{player.name}と#{@dealer}は引き分けです｡"
        next
      end
    end
  end
end

