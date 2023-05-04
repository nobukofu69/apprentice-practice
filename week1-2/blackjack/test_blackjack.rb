require 'minitest/autorun'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'cpu'
require_relative 'result'

class TestBlackJack < Minitest::Test
  # サレンダーのテスト
  def test_cpu
    cpu = Cpu.new
    dealer = Dealer.new('ディーラー')
    cpu.cards = [Card.new('スペード', 5), Card.new('スペード', 10)]
    dealer.cards = [Card.new('ハート', 10)]
    assert_equal  true, cpu.surrender?(dealer.cards[0].number)
  end
end