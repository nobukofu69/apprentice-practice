# frozen_string_literal: true

class BlackJack
  SUIT_LIST = %w[クローバー スペード ハート ダイヤ].freeze
  NUMBERS = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].freeze

  # 絵柄(suit)4種 x 数(13) = 52枚のカードを 0から51の数字で表現した配列に｡
  @@deck = (0..51).to_a
  @@user_lose_flag = false
  attr_reader :score

  def self.result(player, dealer)
    if player.score > 21
      puts "あなたの得点は#{player.score}です"
      puts 'あなたの負けです'
      return
    end
    puts "あなたの得点は#{player.score}です"
    puts "ディーラーの得点は#{dealer.score}です"
    if player.score > dealer.score
      puts 'プレーヤーの勝ちです！'
    elsif  player.score == dealer.score
      puts '引き分けです｡'
    else
      puts 'ディーラーの勝ちです！'
    end
  end

  def initialize
    @score = 0
  end

  def draw
    card = @@deck.sample
    suit = SUIT_LIST[(card / 13)]
    card_number = NUMBERS[card % 13]
    @score +=
      if card_number == 'A' && @score > 10
        1
      elsif card_number == 'A' && @score <= 10
        11
      elsif card_number.is_a?(Integer)
        card_number
      else
        10
      end
    @@deck.delete(card)
    "#{suit}の#{card_number}"
  end
end

# ・現在のプレーヤ得点が表示後､カードを引くか選択する(Y or N)
#   ・Yの場合､プレーヤがドローしカード得点を表示｡
#     ・ここで22点以上の場合､結果発表にジャンプしプレーヤー敗北｡★
#     ・21点以下の場合､再度カードを引くか書かれる｡Yなら繰り返す｡Nならドローフェイズを抜ける
#   ・Nの場合､ドローフェイズを抜ける

class User < BlackJack
  def draw_card?
    if @score > 21
      @@user_lose_flag = true
      return
    end
    puts "あなたの現在の得点は#{@score}です。カードを引きますか？（Y/N）"
    answer = gets.chomp.downcase
    if answer == 'y'
      draw
      draw_card?
    elsif answer == 'n'
      nil
    else
      puts ' YかNを入力してください'
      draw_card?
    end
  end
end

class Dealer < BlackJack
  def initialize
    @score = 0
    @card = 0
  end

  def draw
    @card = super
  end

  def draw_card?
    # プレーヤー全員バーストしていた場合
    return if @@user_lose_flag

    # プレーヤー全員バーストしていない場合､2枚目に引いたカードを公開
    # 17点以上なら結果発表に進む
    puts "ディーラーの引いた2枚目のカードは#{@card}でした。"
    return if @score >= 17

    # 17点未満の場合､現在の得点を公開｡17点以上になるまでカードを引き
    # その都度引いたカードを公開する｡17点以上になったら結果発表へ進む｡
    while @score < 17
      puts "ディーラーの現在の得点は#{@score}です。"
      puts "ディーラーの引いたカードは#{draw}です。"
    end
    nil
  end
end

# ルールみて､どの時点でプレーや､cpuの勝敗が決定するのか確認

player1 = User.new
dealer = Dealer.new
puts 'ブラックジャックを開始します。'
# ・カードを2枚ずつひく｡
# ・ドローすることで山場からカードが減る
# ・プレーヤーが引いたカード2枚が表示される
puts "あなたの引いたカードは#{player1.draw}です。"
puts "あなたの引いたカードは#{player1.draw}です。"
# ・ディーラーが1枚目のカードを引く
puts "ディーラーの引いたカードは#{dealer.draw}です。"
# ・ディーラーが2枚目のカード引く｡ただし引いたカード情報は公開しない｡
dealer.draw
puts 'ディーラーの引いた2枚目のカードはわかりません。'
# ・現在のプレーヤ得点が表示後､カードを引くか選択する(Y or N)
#   ・Yの場合､プレーヤがドローしカード得点を表示｡
#     ・ここで22点以上の場合､結果発表にジャンプしプレーヤー敗北｡★
#     ・21点以下の場合､再度カードを引くか書かれる｡Yなら繰り返す｡Nならドローフェイズを抜ける
#   ・Nの場合､ドローフェイズを抜ける
player1.draw_card?
# ・ディーラー以外に21点以下のプレーヤーがいない場合､ディーラーの勝ち★
# ・プレーヤがいる場合､以降の処理を行う
# ・ディーラが2回目に引いたカード情報が表示される(ここでカードを引く)
# ・ディーラーの得点が17以上の場合､結果発表に入る
# ・ディーラーの得点が17未満の場合､ ドローする
#   ・ディーラーの得点が 17以上の場合､ドローを終了｡結果発表に入る
dealer.draw_card?
BlackJack.result(player1, dealer)
# ・結果発表｡
#   プレーヤーと高い場合､勝ち出力を返す
#   ディーラーが高い場合､勝ち出力を返す
puts 'ブラックジャックを終了します。'
