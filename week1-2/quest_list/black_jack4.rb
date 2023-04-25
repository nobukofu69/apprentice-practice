# ダブルダウンでお金がない場合､再度オプションから選択を求める部分が未実装
# CPUに対しダブルダウンやサレンダーを選択させる部分が未実装
# スプリットの実装が未完了

# frozen_string_literal: true

class BlackJack
  SUIT_LIST = %w[クローバー スペード ハート ダイヤ].freeze
  NUMBERS = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].freeze

  # @@deck は 0〜51の数で絵柄(suit)とカードナンバーを表現する
  # 引いたカードが 15の場合､スペードの３となる

  # suit/ナンバー| A   2   3   4   5   6   7   8   9  10   J   Q   K
  # -------------+--------------------------------------------------
  # クローバー   | 0,  1,  2,  3,  4,  5,  6 , 7,  8,  9, 10, 11, 12,
  # スペード     |13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
  # ハート       |26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38
  # ダイヤ       |39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51

  @@deck = (0..51).to_a
  # ディーラーの得点
  @@dealer_score = 0
  # ディーラーのブラックジャックフラグ
  @@black_jack_flag = false
  # ゲームに参加するプレイヤーの数
  @@active_players = 0

  # デバッグ用
  attr_accessor :hand

  def initialize
    @hand = []
  end

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

  def calculate_hand_score(hand = @hand, i = 0)
    sum = hand.inject(:+)                              
    return sum if sum <= 21

    # --------この先､カードの合計点sumが21点以上の処理--------
    # Aのカード(11)が存在する場合､手札で最初に見つかった11を1に変える
    if hand.include?(11)
      hand[hand.index(11)] = 1
      hand.inject(:+)
    else
      sum
    end
  end
end

class User < BlackJack
  # デバッグ用
  attr_accessor :money

  def initialize
    super
    @name = 'あなた'
    @money = 10000
    @bet_size = 0
    # 各オプションのフラグ
    @black_jack_flag = false
    @double_down_flag = false
    @splitting_pairs = false
    @surrender = false
    # プレイヤー数を1増やす
    @@active_players += 1
  end

  def set_bet_amount
    puts 'ベットしてください｡'
    @bet_size = gets.chomp.to_i
    # bet_siseは 1以上10000未満でのみ受け付ける
    if (1..10000).include?(@bet_size)
      @money -= @bet_size
    else # if条件に該当しない場合､再帰呼び出しでループ
      set_bet_amount
    end
  end

  def deal
    2.times do
      puts "#{@name}の引いたカードは#{draw_card}です。"
    end
    
    if calculate_hand_score == 21
      puts 'ブラックジャック！'
      @black_jack_flag = true
    end
  end

  def player_option
    puts "現在の得点:#{calculate_hand_score}"
    puts "オプション:\n 1:ダブルダウン 2:スプリット 3:サレンダー 4:選択しない"
    selected = gets.chomp.to_i
    case selected
    when 1
      double_down
    when 2
      nil # スプリットは未実装
    when 3 
      surrender
    when 4
      return
    else
      player_option
    end
  end

  def double_down
    # ダブルダウン用のベッド額が払える場合
    if @bet_size <= @money
      @money -=  @bet_size
      @bet_size *= 2
      @double_down_flag = true
    else
      puts 'お金が足りません'
    end
  end
  
  def surrender
    # ベットした金額の半分が戻る
    @money += (@bet_size / 2)
    @surrender = true
    @@active_players -= 1
    puts "#{@name}の負けです｡"
    puts "#{@name}の持ち金は#{@money.to_i}です｡"
  end

  def hit_or_stand
    # サレンダーまたはダブルダウンしている場合､メソッドを抜ける
    return if @surrender || @double_down_flag

    # 21点の場合､メソッドを抜ける
    return if calculate_hand_score == 21

    # 21点を超える場合､負け
    if calculate_hand_score > 21
      puts "#{@name}の得点は#{calculate_hand_score}です。"
      puts "#{@name}の負けです｡"
      puts "#{@name}の持ち金は#{@money.to_i}です｡"
      @@active_players -= 1
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


  end

  def player_results
    # サレンダーしている場合､メソッドを抜ける
    return if @surrender
    
    # 21点超えで負けの場合
    return if calculate_hand_score > 21

    # 自身がブラックジャックの場合
    if @black_jack_flag && !@@black_jack_flag
      @money += @bet_size * 2.5
      puts "#{@name}の勝ちです！"
      puts "#{@name}の持ち金は#{@money.to_i}です｡"
      return

    # 自身とディーラーがブラックジャックの場合
    elsif @black_jack_flag && @@black_jack_flag
      @money += @bet_size
      puts "#{@name}は引き分けです！"
      puts "#{@name}の持ち金は#{@money.to_i}です｡"
      return
    end

    # ディーラーの得点が21点を超えている場合
    if @@dealer_score > 21
      @money += @bet_size * 2
      puts "#{@name}の勝ちです！"
      puts "#{@name}の持ち金は#{@money.to_i}です｡"
      return
    end
    
    # other 
    puts "#{@name}の得点は#{calculate_hand_score}です。"
    # ディーラーより得点が高い
    if calculate_hand_score > @@dealer_score
      puts "#{@name}の勝ちです！"
      @money += @bet_size * 2
    # ディーラーより得点が低い
    elsif @@dealer_score > calculate_hand_score
      puts "#{@name}の負けです！"
    else # 引き分け
      puts "#{@name}は引き分けです！"
      # ダブルダウンの場合､最初のベット額を払い戻し
      if @double_down_flag
        @money += (@bet_size / 2) 
      end
      # 非ダブルダウンの場合､ベット額が払い戻し
      @money += @bet_size
    end
    puts "#{@name}の持ち金は#{@money.to_i}です｡"
  end
end

class Cpu < User
  @@num_of_cpu = 0

  def initialize
    super
    # CPU1,CPU2といった命名規則で名前を付与
    @name = "CPU#{@@num_of_cpu}"
    @@num_of_cpu += 1
  end

  def set_bet_amount
    @bet_size = @money / 10
    @money -= @bet_size
  end

  def hit_or_stand
    # 17点未満の場合､ヒットする
    while calculate_hand_score < 17
      puts "#{@name}の現在の得点は#{calculate_hand_score}です。"
      puts "#{@name}の引いたカードは#{draw_card}です。"
    end
    # 21点以下の場合､スタンドする
    return if calculate_hand_score <= 21

    # 21点超えの処理
    puts "#{@name}の負けです｡"
    puts "#{@name}の持ち金は#{@money.to_i}です｡"
    @@active_players -= 1
  end
end

class Dealer < BlackJack
  def initialize
    super
    @name = 'ディーラー'
  end

  def deal
    puts "#{@name}の引いたカードは#{draw_card}です。"
    @second_card = draw_card
    puts 'ディーラーの引いた2枚目のカードはわかりません。'
  end

  def draw_card
    @last_card = super
  end

  def hit_or_stand
    # プレーヤー全員がバーストしていた場合､hit_or_standメソッドを抜ける｡
    return if @@active_players.zero?
    
    puts "#{@name}の引いた2枚目のカードは#{@second_card}でした。"
    # ブラックジャックの場合は処理を抜け結果発表へ
    if calculate_hand_score == 21
      puts 'ブラックジャック！'
      @@black_jack_flag = true
      return
    end
    # 17点未満の場合､ヒットする
    while calculate_hand_score < 17
      puts "#{@name}の現在の得点は#{calculate_hand_score}です。"
      puts "#{@name}の引いたカードは#{draw_card}です。"
    end
    # 17点超えた場合､得点を出力しスコアに反映
    puts "#{@name}の得点は#{calculate_hand_score}です。"
    @@dealer_score += calculate_hand_score
  end
end

# # インスタンス生成
you = User.new
# cpu1 = Cpu.new
# cpu2 = Cpu.new
dealer = Dealer.new

puts 'ブラックジャックを開始します。'

# ベット
you.set_bet_amount
# cpu1.set_bet_amount
# cpu2.set_bet_amount

# ディール
you.deal
# cpu1.deal
# cpu2.deal
dealer.deal

# プレーヤープション
you.player_option

# ヒット or スタンドする
you.hit_or_stand
# cpu1.hit_or_stand
# cpu2.hit_or_stand
dealer.hit_or_stand

# # プレーヤーの勝敗を出力
you.player_results
# cpu1.player_results
# cpu2.player_results
puts 'ブラックジャックを終了します。'
