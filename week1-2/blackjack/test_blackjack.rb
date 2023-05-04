require 'minitest/autorun'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'cpu'
require_relative 'result'

class TestBlackJack < Minitest::Test
  # CPUサレンダーのテスト
  def test_cpu_surrender
    cpu = Cpu.new
    dealer = Dealer.new('ディーラー')

    # CPUの得点が15､ディーラーの1枚目の得点が10の場合､サレンダーする
    cpu.cards = [Card.new('スペード', 5), Card.new('スペード', 10)]
    assert_equal  true, cpu.surrender?(Card.new('ハート', 10))

    # CPUの得点が16､ディーラーの1枚目の得点が9,10,11のいずれかの場合､サレンダーする
    cpu.cards = [Card.new('スペード', 6), Card.new('スペード', 10)]
    assert_equal  true, cpu.surrender?(Card.new('ハート', 9))
    assert_equal  true, cpu.surrender?(Card.new('ハート', 10))
    assert_equal  true, cpu.surrender?(Card.new('ハート', 11))
  end

  # CPUダブルダウンのテスト
  def test_cpu_double_down
    cpu = Cpu.new
    dealer = Dealer.new('ディーラー')
    # CPUの手札が5のペアではない､または手札にAが含まれない場合､ダブルダウンしない
    cpu.cards = [Card.new('スペード', 7), Card.new('スペード', 5)]
    assert_equal false, cpu.double_down?(Card.new('ハート', 2))
    
    # CPUの手札が5のペア､かつ､ディーラーの1枚目の得点が2から9の場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 5), Card.new('ダイヤ', 5)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 2))
    assert_equal true, cpu.double_down?(Card.new('ハート', 3))
    assert_equal true, cpu.double_down?(Card.new('ハート', 4))
    assert_equal true, cpu.double_down?(Card.new('ハート', 5))
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    assert_equal true, cpu.double_down?(Card.new('ハート', 7))
    assert_equal true, cpu.double_down?(Card.new('ハート', 8))
    assert_equal true, cpu.double_down?(Card.new('ハート', 9))
    
    # ---CPUの手札にAが含まれる場合の条件分岐 ここから---
    # CPUの得点が13､ディーラーの1枚目の得点が5,6いずれかの場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 2)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 5))
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    # CPUの得点が14､ディーラーの1枚目の得点が5,6いずれかの場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 3)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 5))
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    # CPUの得点が15､ディーラーの1枚目の得点が4〜6の場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 4)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 4))
    assert_equal true, cpu.double_down?(Card.new('ハート', 5))
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    # CPUの得点が16､ディーラーの1枚目の得点が4〜6の場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 5)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 4))
    assert_equal true, cpu.double_down?(Card.new('ハート', 5))
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    # CPUの得点が17､ディーラーの1枚目の得点が3〜6の場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 6)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 3))
    assert_equal true, cpu.double_down?(Card.new('ハート', 4))
    assert_equal true, cpu.double_down?(Card.new('ハート', 5))
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    # CPUの得点が18､ディーラーの1枚目の得点が2〜6の場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 7)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 2))
    assert_equal true, cpu.double_down?(Card.new('ハート', 3))
    assert_equal true, cpu.double_down?(Card.new('ハート', 4))
    assert_equal true, cpu.double_down?(Card.new('ハート', 5))
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    # CPUの得点が19､ディーラーの1枚目の得点が6の場合､ダブルダウンする
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 8)]
    assert_equal true, cpu.double_down?(Card.new('ハート', 6))
    # ---CPUの手札にAが含まれる場合の条件分岐 ここまで---
    
  end
end