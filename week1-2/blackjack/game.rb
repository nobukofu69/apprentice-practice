require 'debug'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'result'
require_relative 'cpu'

class Game
  attr_reader :player, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new('あなた')
    @dealer = Dealer.new('ディーラー')
    @cpu1 = Cpu.new
    @cpu2 = Cpu.new
    @game_members = [@player, @cpu1, @cpu2, @dealer]
  end

  def play
    puts 'ブラックジャックを開始します。'

    # ゲームメンバーにカードを2枚ずつ配る
    @game_members.each do |member|
      member.deal(@deck)
    end

    # ゲームメンバーがカードを引くかどうかを決める
    @game_members.each do |member|
      member.hit_or_stand(@deck)
      # プレーヤーが全員バーストしていた場合､ゲームを終了する
      if Player.player_count == 0
        puts '全てのプレーヤーがバーストしたため､ゲームを終了します｡'
        exit
      end
    end


    Result.new(@dealer, @player, @cpu1, @cpu2).judge
  end
end

Game.new.play