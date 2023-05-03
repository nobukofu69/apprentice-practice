require 'minitest/autorun'
require_relative 'game'
require_relative 'deck'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'cpu'
require_relative 'hand'
require_relative 'result'

class TestBlackJack < Minitest::Test
  def test_cpu
    cpu = Cpu.new
    dealer = Dealer.new('ディーラー')
    cpu.cards = [Card.new('スペード', 5), Card.new('スペード', 10)]
    dealer.cards = [Card.new('ハート', 5), Card.new('ダイヤ', 5)]
    assert_equal 15, cpu.score
  end
end