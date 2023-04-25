# frozen_string_literal: true

class BlackJack
  SUIT_LIST = %w[クローバー スペード ハート ダイヤ].freeze
  NUMBERS = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].freeze

  @@deck = (0..51).to_a

  attr_reader :user_score, :cpu_score

  def initialize
    @user_score = 0
    @cpu_score = 0
  end

  def draw_user
    deck_number = @@deck.sample
    suit = SUIT_LIST[(deck_number / 13)]
    number = NUMBERS[deck_number % 13]
    @user_score += if number == 'A' && @user_score > 11
                     1
                   elsif number == 'A' && @user_score <= 11
                     10
                   elsif number.is_a?(Integer)
                     number
                   else
                     10
                   end
    @@deck.delete(deck_number)
    "#{suit}の#{number}"
  end

  def draw_cpu
    deck_number = @@deck.sample
    suit = SUIT_LIST[(deck_number / 13)]
    number = NUMBERS[deck_number % 13]
    @cpu_score += if number == 'A' && @cpu_score > 11
                    1
                  elsif number == 'A' && @cpu_score <= 11
                    10
                  elsif number.is_a?(Integer)
                    number
                  else
                    10
                  end
    @@deck.delete(deck_number)
    "#{suit}の#{number}"
  end

  def draw_or_not_by_user
    if @user_score > 21
      puts "あなたの得点は#{@user_score}です。"
      puts 'ディーラーの勝ちです'
      return
    end
    puts "あなたの現在の得点は#{@user_score}です。カードを引きますか？（Y/N）"
    answer = gets.chomp
    if answer == 'Y'
      puts "あなたの引いたカードは#{draw_user}です。"
      draw_or_not_by_user
    elsif answer == 'N'
      puts "ディーラーの引いた2枚目のカードは#{draw_cpu}でした。"
      puts "ディーラーの現在の得点は#{cpu_score}です"
      draw_or_not_by_cpu
    end
  end

  def draw_or_not_by_cpu
    if @cpu_score >= 17
      result
    else
      puts "ディーラーの引いたカードは#{draw_cpu}です｡"
      draw_or_not_by_cpu
    end
  end

  def result
    puts "あなたの得点は#{user_score}です｡"
    puts "ディーラーの得点は#{cpu_score}です"
    if user_score > cpu_score
      puts 'あなたの勝ちです!'
    elsif user_score < cpu_score
      puts 'ディーラーの勝ちです!'
    else
      puts '引き分けです'
    end
  end
end

game1 = BlackJack.new

puts 'ブラックジャックを開始します。'
puts "あなたの引いたカードは#{game1.draw_user}です｡"
puts "あなたの引いたカードは#{game1.draw_user}です｡"
puts "ディーラーの引いたカードは#{game1.draw_cpu}です｡"
puts 'ディーラーの引いた2枚目のカードはわかりません｡'
game1.draw_or_not_by_user
puts 'ブラックジャックを終了します'
