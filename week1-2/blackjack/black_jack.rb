require 'debug'
require_relative 'deck'
require_relative 'player'
require_relative 'hand'

class BlackJack

  def initialize
    @deck = Deck.new
    @player = Player.new('あなた', Hand.new)
    @dealer = Player.new('ディーラー', Hand.new)
  end

  def play
    puts 'ブラックジャックを開始します。'
    @player.draw(@deck, 2)
    puts "#{@player.name}の引いたカードは#{@player.cards[0]}です。"
    puts "#{@player.name}の引いたカードは#{@player.cards[1]}です。"
    puts "あなたの現在の得点は#{@player.hand}です。カードを引きますか？（Y/N）"



    # @dealer.draw(@deck, 2)
    # puts "#{@dealer.name}の引いたカードは#{@dealer.cards[0]}です。"
    # puts "#{@dealer.name}の引いたカードは分かりません。"

    # puts 'ブラックジャックを終了します。'
  end
end

game = BlackJack.new
game.play

