require 'debug'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'result'
require_relative 'cpu'

# ブラックジャックのゲームを管理するクラス
class Game
  attr_reader :player, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new('あなた')
    @dealer = Dealer.new('ディーラー')
    @cpu1 = Cpu.new
    @cpu2 = Cpu.new
    @player_members = [@player, @cpu1, @cpu2]
  end

  def play
    puts 'ブラックジャックを開始します。'
    # プレーヤーがべットする
    @player_members.each { |member| member.set_bet_amount}

    # プレーヤーにカードを2枚ずつ配る｡
    # ブラックジャックだった場合､メッセージを表示する
    @player_members.each do |member| 
      member.deal(@deck) 
      member.check_blackjack
    end
    
    # ディーラーにカードを2枚配る｡
    @dealer.deal(@deck)

    # 非ブラックジャックのプレーヤーにオプションを表示､選択させる
    @player_members.each do |member| 
      unless member.blackjack_flag 
        member.player_options(@dealer.cards[0])
      end
    end

    # プレーヤーがヒットするかスタンドするかを決める｡
    @player_members.each do |member|
      member.hit_or_stand(@deck)
    end

    # アクティブなプレーヤーがいない場合､ゲームを終了する
    if Player.player_count.zero?
      puts 'ゲームを終了します｡'
      exit
    end

    # 参加プレーヤーが残っている場合､ディーラーの2枚目のカードを表示する
    puts "#{@dealer.name}の引いた2枚目のカードは#{@dealer.cards[1]}でした。"
    # ディーラーがブラックジャックだった場合､メッセージを表示する
    @dealer.check_blackjack
    # ディーラーが17点以上になるまでヒットする
    @dealer.auto_hit(@deck)
    
    # 結果を表示する
    Result.new(@dealer, @player_members).judge
  end
end

Game.new.play