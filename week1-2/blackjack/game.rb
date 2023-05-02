require 'debug'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'result'

class Game
  attr_reader :player, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new('あなた')
    @dealer = Dealer.new('ディーラー')
  end

  def play
    puts 'ブラックジャックを開始します。'

    @player.draw(@deck, 2)
    puts "#{@player.name}の引いたカードは#{@player.cards[0].to_s}です。"
    puts "#{@player.name}の引いたカードは#{@player.cards[1].to_s}です。"

    @dealer.draw(@deck, 2)
    puts "#{@dealer.name}の引いたカードは#{@dealer.cards[0].to_s}です。"
    puts 'ディーラーの引いたカードはわかりません。'

    @player.hit_or_stand(@deck)
    # プレーヤーが全員バーストしていた場合､ゲームを終了する
    return if Player.player_count == 0
    
    puts "#{@dealer.name}の引いたカードは#{@dealer.cards[1].to_s}でした｡"
    @dealer.hit_or_stand(@deck)
    Result.new(@dealer, @player).judge
  end
end

Game.new.play