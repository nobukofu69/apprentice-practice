require 'debug'
require_relative 'hand'

class Player
  @@player_count ||= 0
  attr_reader :name, :bet_size, :blackjack_flag, :splitting_pairs_flag,
              :surrender_flag, :splitting_pairs
  attr_accessor :money,:cards, :cards2, :bet_size, :double_down_flag

  # プレイヤーの人数を返すクラス
  def self.player_count
    @@player_count
  end

  def initialize(name)
    @@player_count += 1
    @name = name
    @cards = []
    @money = 10_000
    @bet_size = 0
    # 以下各種フラグ
    @blackjack_flag = false
    @double_down_flag = false
    @splitting_pairs_flag = false
    @surrender_flag = false
  end

  # ベットする
  def set_bet_amount
    while true
      puts 'ベットしてください｡'
      @bet_size = gets.chomp.to_i
      # bet_siseは 1以上10000未満でのみ受け付ける
      if (1..10_000).include?(@bet_size)
        @money -= @bet_size
        break
      end
    end
  end

  # カードを引く
  def draw(deck, number = 1)
    number.times do
      @cards << deck.draw
    end
  end

  # 配列として受け取った手札の得点を表示する.
  def score(value = @cards)
    Hand.new(value).score
  end

  # プレーヤーオプションを選択する
  def player_options(dealer_up_card)
    while true
      puts "現在の得点: #{score}, ディーラーの得点: #{score([dealer_up_card])}"
      puts "オプション:\n 1:ダブルダウン 2:スプリット 3:サレンダー 4:Exit"
      selected = gets.chomp.to_i
      case selected
      # ダブルダウン
      when 1
        # ダブルダウン用のベッド額が払える場合
        if @bet_size <= @money
          @money -=  @bet_size
          @bet_size *= 2
          @double_down_flag = true
          return
        else
          puts 'お金が足りません'
        end
      # スプリット
      when 2
        # 手札がペアではない､またはスプリット用のベッド額が払えない場合
        unless @cards[0].number == @cards[1].number && @bet_size <= @money
          puts 'スプリットできません'
          next
        end
        # スプリットできる場合
        @money -= @bet_size
        @splitting_pairs_flag = true
        # 2枚目のカードを別の配列に移す
        @cards2 = [@cards.pop]
        # 分けた手札を更に配列として管理する
        @splitting_pairs = [@cards, @cards2]
        return
      # サレンダー
      when 3 
        # サレンダーフラグ立ち､ベット額の半分が返ってくる
        @surrender_flag = true
        @money += (@bet_size / 2)
        @@player_count -= 1
        puts "#{@name}はサレンダーしました｡"
        puts "#{@name}の持ち金は#{@money}円です。"
        return
      when 4
        return
      end
    end
  end

  # ディールして､引いたカードを表示する
  def deal(deck)
    2.times do |i|
      draw(deck)
      puts "#{@name}の引いた#{i + 1}枚目のカードは#{@cards[i]}です"
    end
  end

  # ブラックジャックだった場合､メッセージを表示してフラグを立てる
  def check_blackjack
    if score == 21 && @cards.size == 2
      puts "#{@name}はブラックジャックです！" 
      @blackjack_flag = true
    end
  end

  # ヒットするかスタンドするかを決める
  def hit_or_stand(deck)
    # ブラックジャックまたはサレンダーの場合､メソッドを抜ける
    return if @blackjack_flag || @surrender_flag

    # スプリットしている場合の処理
    if @splitting_pairs_flag
      @splitting_pairs.each_with_index do |cards, i|
        while score(cards) < 21
          puts "#{@name}の手札#{i + 1}の得点は#{score(cards)}です。カードを引きますか？（Y/N）"
          answer = gets.chomp.downcase
          # yが入力された場合､カードを引く
          if answer == 'y'
            draw(deck)
            puts "#{@name}の引いたカードは#{cards.last}です。"
          # nが入力された場合､スタンドする
          elsif answer == 'n'
            puts "#{@name}は手札#{i + 1}でスタンドしました｡"
            # whileを抜ける
            break
          # y/n以外が入力された場合､もう一度入力を促す
          else 
            puts 'YまたはNを入力してください｡'
            next
          end
        end
        # whileを抜けた時点の手札が21点の場合､スタンドする
        if score(cards) == 21
          puts "#{@name}の手札#{i + 1}の得点は#{score(cards)}です。"
          puts "#{@name}は手札#{i + 1}でスタンドしました｡"
        end

        # バーストしているかを確認する
        display_burst

        # 手札1の場合､手札2に移る
        next if i == 0
        # 手札2の場合､メソッドを抜ける
        return
      end
    end

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

    # 21点未満の場合､Nを押すまでカードを引くか選択し続ける
    while score < 21
      puts "#{@name}の現在の得点は#{score}です。カードを引きますか？（Y/N）"
      answer = gets.chomp.downcase
      # yが入力された場合､カードを引く
      if answer == 'y'
        draw(deck)
        puts "#{@name}の引いたカードは#{@cards.last}です。"
      # nが入力された場合､スタンドする
      elsif answer == 'n'
        puts "#{@name}はスタンドしました｡"
        return
      # y/n以外が入力された場合､もう一度入力を促す
      else
        puts 'YまたはNを入力してください｡'
        next
      end
    end
    # ループを抜けた時点で21点の場合､スタンドする
    if score == 21
      puts "#{@name}の得点は#{score}です。"
      puts "#{@name}はスタンドしました｡"
    # ループを抜けた時点で21点を超えている場合､バーストする
    else 
      display_burst
    end
  end

  # バーストしていた場合､プレイヤーの人数を減らしてメッセージを表示する
  def display_burst(value = @cards, i = 0)
    # 非スプリットで21点を超えた場合
    if !@splitting_pairs_flag
      puts "#{@name}の得点は#{score(value)}です。"
      puts "#{@name}はバーストしました｡"
      puts "#{@name}の持ち金は#{@money}円です。"
      @@player_count -= 1
      return
    end
    
    # スプリットした手札で21点を超えた場合
    if score(value) > 21
      puts "#{@name}の手札#{i + 1}の得点は#{score(value)}です。"
      puts "#{@name}はバーストしました｡"
    # スプリットした手札で21点以下の場合､処理をぬける
    elsif @splitting_pairs_flag && score(value) <= 21
      return
    end
  
    # スプリットした全ての手札で21点を超えた場合､プレイヤーの人数を減らす
  end
end