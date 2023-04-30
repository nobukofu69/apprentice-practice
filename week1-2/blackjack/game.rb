require 'debug'
require_relative 'deck'
require_relative 'player'

class Game
  def initialize
    @player = Player.new('あなた')
    @deck = Deck.new
  end

game = Game.new
puts 'ブラックジャックを開始します。'
puts "あなたの引いたカードは#{@player.draw(@deck)}です。"
end