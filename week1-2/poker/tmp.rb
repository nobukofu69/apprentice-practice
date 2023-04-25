# gem 'debug'
require 'debug'

def set_deck
  deck = []
  suits = %w[スペード ハート ダイヤ クローバー]
  numbers = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  suits.each do |suit|
    numbers.each do |number|
      deck << [suit, number]
    end
  end
  deck.shuffle
end

def draw_cards(deck, num)
  deck.pop(num)
end

def score(card)
  return card[1].to_i if card[1].to_i != 0
  case card[1]
  when 'J' then 11
  when 'Q' then 12
  when 'K' then 13
  when 'A' then 1
  end
end

def hand(cards)
  scores = cards.map { |card| score(card) }.sort
  if cards.size == 2
    if scores[1] == scores[0] + 1 || scores[1] == scores[0] + 12
      'ストレート'
    elsif scores[0] == scores[1]
      'ペア'
    else
      'ハイカード'
    end
  elsif cards.size == 3
    if scores[2] == ((scores[0] + 2) && (scores[1] + 1)) ||
       scores[2] == ((scores[0] + 12) && (scores[1] + 1)) ||# 1, 12, 13
       scores[2] == ((scores[0] + 12) && (scores[1] + 11))  # 1, 2, 13
        'ストレート'
    elsif scores[0] == scores[1] && scores[1] == scores[2]
      'スリーカード'
    elsif scores[0] == scores[1] || scores[1] == scores[2]
      'ワンペア'
    else
      'ハイカード'
    end
  end
end

number_cards = 0
deck = set_deck

puts 'ポーカーを開始します' 
puts 'ポーカーを開始します。カードを引く枚数を選択してください（2, 3）：'
answer = 3 # 後で消す
while number_cards = gets.chomp.to_i
  if number_cards == 2 || number_cards == 3
    break
  else
    puts '2か3を入力してください'
  end
end

player_cards = [["ダイヤ","1"],["スペード","1"],["スペード","12"]] # 後で直す
# player_cards += draw_cards(deck, number_cards) 後で直す
player_cards.each_with_index do |card, i|
  puts "あなたの引いたカードは#{player_cards[i][0]}の#{player_cards[i][1]}です｡"
end

dealer_cards = []
dealer_cards += draw_cards(deck, number_cards)
dealer_cards.each_with_index do |card, i|
  puts "ディーラーの引いたカードは#{dealer_cards[i][0]}の#{dealer_cards[i][1]}です｡"
end

puts "あなたの役は#{hand(player_cards)}です"
puts "ディーラーの役は#{hand(dealer_cards)}です"
puts 'ポーカーを終了します'