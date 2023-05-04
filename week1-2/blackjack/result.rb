require 'debug'

class Result
  def initialize(dealer, players)
    @dealer = dealer
    @players = players
  end

  def judge
    puts '結果発表！' 
    @players.each do |player|
      # プレーヤーがサレンダーまたはバーストしていた場合
      next if player.score > 21 || player.surrender_flag

      # プレーヤーかディーラーにブラックジャックフラグが立っている場合
      if player.blackjack_flag 
        player.money += player.bet_size * 2.5
        puts "#{player.name}の勝ちです！"
        puts "#{player.name}の持ち金は#{player.money.to_i}です｡"
        next
      elsif @dealer.blackjack_flag
        puts "#{player.name}の負けです｡"
        puts "#{player.name}の持ち金は#{player.money.to_i}です｡"
        next
      end
      
      # プレーヤーとディーラーのブラックジャックフラグが揃っている場合
      if @dealer.score > 21 || player.score > @dealer.score
        puts "#{player.name}の勝ちです！"
        player.money += player.bet_size * 2
      elsif player.score < @dealer.score
        puts "#{player.name}の負けです｡"
      else 
        puts "#{player.name}は引き分けです｡"
        # ダブルダウンの場合､最初のベット額を払い戻し
        if player.double_down_flag
          player.money += (player.bet_size / 2)
        # 非ダブルダウンの場合､ベット額が払い戻し
        else
          player.money += player.bet_size
        end
      end
      # プレーヤーの持ち金を表示
      puts "#{player.name}の持ち金は#{player.money.to_i}です｡"
    end
  end
end

