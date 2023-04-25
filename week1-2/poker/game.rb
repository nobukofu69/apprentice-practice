# 1時間38分まではちゃんと見た

require 'debug'

require_relative 'deck'
require_relative 'player'

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new('あなた')
    @dealer = Player.new('ディーラー')
  end
  
  def play
    puts "ポーカーを開始します。"
    @player.draw(@deck, 2)
    puts "#{@player.name}の引いたカードは#{@player.cards[0].to_s}です。"
    puts "#{@player.name}の引いたカードは#{@player.cards[1].to_s}です。"
    @dealer.draw(@deck, 2)
    puts "#{@dealer.name}の引いたカードは#{@dealer.cards[0].to_s}です。"
    puts "#{@dealer.name}の引いたカードは#{@dealer.cards[1].to_s}です。"
    binding.break
  end
end