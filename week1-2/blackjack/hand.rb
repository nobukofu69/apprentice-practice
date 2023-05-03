require 'debug'

# 手札に関するクラス
class Hand
  def initialize(cards)
    @cards = cards
    @card_numbers = []
    @cards.each do | card |
      @card_numbers << case card.number
        when 'A'
          11
        when 'J', 'Q', 'K'
          10
        else
          card.number.to_i
        end
    end
  end

  # 手札の合計値を計算する
  def score
    # 手札の合計値を計算する
    hand_sum = @card_numbers.inject(:+)
    # 手札の合計値が21点以下または､Aのカード(11)が存在しない場合､手札の合計値を返す
    if hand_sum <= 21 || !@card_numbers.include?(11)
      return hand_sum
    end
    # 手札の合計値が21点以上､かつAのカード(11)が存在するので､Aのカード(11)を1に変える
    @card_numbers[@card_numbers.index(11)] = 1
    # 手札の合計値を再計算して返す
    @card_numbers.inject(:+)
  end
end