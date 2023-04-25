■今やってること
・スプリット毎にドロー(まだ)
・スプリットごとに集計(まだ)
■やったこと
・calculate_hand_score にデフォルトの引数
・ スプリットごとにヒット

必要なもの
@split_score_1(まだ)
@split_score_2(まだ)
@split_hand_1
@split_hand_2
@bet_size

calculate_hand_score 
you.hit_or_stand
you.player_results

class Shimoi
  def initialize
    @hand = [3,3,3,3,3]
    @split_hand_1 = [2,2,2,2,2]
  end
  def hello(a = @hand)
    puts a.inject(:+)
  end
end


def hit_or_stand
  # サレンダーしている場合､メソッドを抜ける
  return if @surrender

  # スプリットしている場合､スプリット用のメソッドへ移動
  if @splitting_pairs
    hit_or_stand_split
    return
  end

  while calculate_hand_score < 21
    puts "#{@name}の現在の得点は#{calculate_hand_score}です。カードを引きますか？（Y/N）"
    answer = gets.chomp.downcase
    if answer == 'y'
      puts "#{@name}の引いたカードは#{draw_card}です。"
      # ダブルダウンしている場合､ここでwhileを抜ける
      return if @double_down_flag
    elsif answer == 'n'
      return
    else
      next
    end
  end

  # 21点の場合､メソッドを抜ける
  return if calculate_hand_score == 21

  # 21点を超える場合
  puts "#{@name}の得点は#{calculate_hand_score}です。"
  puts "#{@name}の負けです｡"
  puts "#{@name}の持ち金は#{@money.to_i}です｡"
  @@active_players -= 1
end




手札
@hand

ベット
@bet_size


★スプリットの処理
スプリットで結果発表時の処理
→得点を変数で管理するのは？
 →あり｡これを既存と異なる変数にして､既存処理と
   バッティングしないようsにする
   →上の2回目の処理でreturnさせたら？

# スプリット､ディーラーが21点超え
   ・手札1の得点が21点以下の場合､
   ・手札1の勝ちです｡
   ・手札1のベット2倍を@moneyに追加
   ・それ以外
   ・手札1の負けです｡
   end
   ・以下ループ


■やりたいこと

  def draw_card
    card = @@deck.sample
    # 絵柄を suit に代入
    suit = SUIT_LIST[(card / 13)]
    # カードナンバーを card_number に代入
    card_number = NUMBERS[card % 13]
    @hand << case card_number
             when 'A'
               11
             when 'J', 'Q', 'K'
               10
             else # card_number が数字のとき
               card_number
             end
    @@deck.delete(card)
    "#{suit}の#{card_number}"
  end

  def calculate_hand_score
    sum = @hand.inject(:+)
    return sum if sum <= 21

    # --------この先､カードの合計点sumが21点以上の処理--------
    # Aのカード(11)が存在する場合､手札で最初に見つかった11を1に変える
    if @hand.include?(11)
      @hand[@hand.index(11)] = 1
      @hand.inject(:+)
    else
      sum
    end
  end
  



