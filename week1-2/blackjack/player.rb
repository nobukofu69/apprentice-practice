require 'debug'
require_relative 'hand'

class Player
  @@player_count ||= 0
  attr_reader :name, :cards, :bet_size, :blackjack_flag
  attr_accessor :money

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
    @blackjack_flag = false
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

  # 現在の得点を表示する
  def score
    Hand.new(@cards).score
  end

  # ディールして､引いたカードを表示する
  def deal(deck)
    2.times do |i|
      draw(deck)
      puts "#{@name}の引いた#{i + 1}枚目のカードは#{@cards[i]}です"
    end
  end

  # ブラックジャックだった場合､メッセージを表示してフラグを立てる
  def announce_blackjack
    if score == 21 && @cards.size == 2
      puts "#{@name}はブラックジャックです！" 
      @blackjack_flag = true
    end
  end

  # ヒットするかスタンドするかを決める
  def hit_or_stand(deck)
    # ブラックジャックの場合､メソッドを抜ける
    return if @blackjack_flag

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
        next
      end
    end
    # ループを抜けた時点で21点の場合､スタンドする
    if score == 21
      puts "#{@name}の得点は#{score}です。"
      puts "#{@name}はスタンドしました｡"
    end
  end

  # バーストしていた場合､プレイヤーの人数を減らしてメッセージを表示する
  def check_burst
    if score > 21
      puts "#{@name}の得点は#{score}です。"
      puts "#{@name}はバーストしました｡"
      puts "#{@name}の持ち金は#{@money}円です。"
      @@player_count -= 1
    end
  end
end