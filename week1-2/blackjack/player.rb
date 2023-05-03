require 'debug'
require_relative 'hand'

class Player
  @@player_count ||= 0
  attr_reader :name, :cards

  # プレイヤーの人数を返すクラス
  def self.player_count
    @@player_count
  end

  def initialize(name)
    @@player_count += 1
    @name = name
    @cards = []
  end

  # カードを引く
  def draw(deck, number = 1)
    number.times do
      @cards << deck.draw
    end
  end

  # ディールする
  def deal(deck)
    2.times do |i|
      draw(deck)
      puts "#{@name}の引いた#{i + 1}枚目のカードは#{@cards[i]}です"
    end
  end

  # 現在の得点を返す
  def score
    Hand.new(@cards).score
  end

  # ヒットするかスタンドするかを決める
  def hit_or_stand(deck)
    # 21点未満の場合､カードを引くかどうかを選択
    while score < 21
      puts "#{@name}の現在の得点は#{score}です。カードを引きますか？（Y/N）"
      answer = gets.chomp.downcase
      if answer == 'y'
        draw(deck)
        puts "#{@name}の引いたカードは#{@cards.last.to_s}です。"
      elsif answer == 'n'
        return
      else
        next
      end
    end

    # 21点の場合どうする？

    # 21点を超えるた場合の処理
    puts "#{name}の得点は#{score}です。"
    puts "バーストしたため#{@name}の負けです｡"
    @@player_count -= 1
  end
end