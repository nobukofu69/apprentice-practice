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
    # 以下各種フラグ
    @blackjack_flag = false
    @double_down_flag = false
    @splitting_pairs = false
    @surrender_flag = false
  end  

  # 手持ちの10%をベットする
  def set_bet_amount
    @bet_size = @money / 10
    @money -= @bet_size
  end

  # ダブルダウンの判断基準を満たしているか判定する
  def double_down?(dealer_up_card)
    # ダブルダウン用のベッド額が払えない場合､メソッドを抜ける
    return false if @bet_size > @money
    # 手札が5のペア､または手札にAが含まれるという条件を満たさない場合､メソッドを抜ける
    unless (cards[0].number == cards[1].number && score == 10) ||
           (cards[0].number == 11) || 
           (cards[1].number == 11)
      return false
    end

    # 手札が5のペア､かつ､ディーラーのアップカードが2から9の場合､trueを返す
    if (cards[0].number == cards[1].number) && 
      score == 10 &&
      dealer_up_card.number.between?(2, 9)
      return true
    end

    # 手札にAが含まれ､かつ､以下に当てはまる場合､trueを返す
    case dealer_up_card.number
    when 2
      score == 18
    when 3
      score.between?(17, 18)
    when 4
      score.between?(15, 18)
    when 5
      score.between?(13, 18)
    when 6
      score.between?(13, 19)
    else
      false
    end
  end

  # サレンダーの判断基準を満たしているか判定する
  def surrender?(dealer_up_card)
    # 得点が15,16以外の場合､falseを返す
    return false if ![15, 16].include?(score)
    
    # 以下に当てはまる場合､trueを返す
    case score
    when 15
      dealer_up_card.number == 10
    when 16
      [9, 10, 11].include?(dealer_up_card.number)
    else
      false
    end
  end

  # プレーヤーオプションを選択する
  def player_options(dealer_up_card)
    # ダブルダウンの判断基準を満たしている場合､ダブルダウンする
    if double_down?(dealer_up_card)
      puts "#{@name}はダブルダウンしました｡"
      @money -=  @bet_size
      @bet_size *= 2
      @double_down_flag = true
      return
    end

    # サレンダーの判断基準を満たしている場合､サレンダーする
    if surrender?(dealer_up_card)
      @surrender_flag = true
      @money += (@bet_size / 2)
      @@player_count -= 1
      puts "#{@name}はサレンダーしました｡"
      puts "#{@name}の持ち金は#{@money}円です。"
      return
    end
  end

  # カードを引くかどうかを決める
  def hit_or_stand(deck)
    # ブラックジャックまたはサレンダーの場合､メソッドを抜ける
    return if @blackjack_flag || @surrender_flag

    # ダブルダウンしている場合､カードを1枚引いてメソッドを抜ける
    if @double_down_flag
      draw(deck)
      puts "#{@name}の引いたカードは#{@cards.last}です。"
      # 21点を超えている場合､バーストしてメソッドを抜ける
      return display_burst if score > 21
      # 21点以下の場合
      puts "#{@name}の得点は#{score}です。"
      return
    end

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

    # ループを抜けた時点の得点に応じて処理を行う
    if score > 21
      return display_burst
    else
      puts "#{@name}の得点は#{score}です｡"
      puts "#{@name}はスタンドしました｡"
    end
  end
end