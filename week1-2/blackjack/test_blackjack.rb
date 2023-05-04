require 'minitest/autorun'
require_relative 'deck'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'cpu'
require_relative 'result'

class TestBlackJack < Minitest::Test
  # CPUサレンダーのテスト
  def test_cpu_surrender
    cpu = Cpu.new
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

    # ダブルダウン用のお金がない場合､ダブルダウンしない
    cpu = Cpu.new
    cpu.bet_size = 10001
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 8)]
    assert_equal false, cpu.double_down?(Card.new('ハート', 6))

    # ---ダブルダウン後､1回しかヒットしないことを確認 ここから---
    cpu = Cpu.new
    deck = Deck.new
    dealer = Dealer.new('ディーラー')
    # ダブルダウンの条件を満たすよう手札を構成する
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 2)]
    dealer.cards = [Card.new('ハート', 5)]
    # デッキを数字の3のみで構成する
    deck.cards = [Card.new('スペード', 3), Card.new('ダイヤ', 3), Card.new('ハート', 3), Card.new('クラブ', 3)]
    # ダブルダウンフラグをtrueにする
    # cpu.double_down_flag = true
    # cpu.hit_or_stand(deck)
    # assert_equal 3, cpu.cards.length
    # ---ダブルダウン後､1回しかヒットしないことを確認 ここまで---

    # --- ダブルダウン時における結果発表後のお金の増減のテスト ここから---
    cpu = Cpu.new
    deck = Deck.new
    dealer = Dealer.new('ディーラー')
    cpu.money = 10000
    cpu.bet_size = 10000
    # ダブルダウンフラグをtrueにする
    cpu.double_down_flag = true
    # CPUが勝つ場合､賭け金の2倍のお金が増えることを確認
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 2), Card.new('ダイヤ', 8)]
    dealer.cards = [Card.new('ハート', 5), Card.new('ハート', 4), Card.new('ハート', 8)]
    Result.new(dealer, [cpu]).judge
    assert_equal 30000, cpu.money
    # CPUが引き分けの場合､賭け金の半分が戻っていることを確認
    cpu.cards = [Card.new('スペード', 11), Card.new('ダイヤ', 2), Card.new('ダイヤ', 8)]
    dealer.cards = [Card.new('ハート', 11), Card.new('ハート', 2), Card.new('ハート', 8)]
    Result.new(dealer, [cpu]).judge
    assert_equal 15000, cpu.money
    # --- ダブルダウン時における結果発表後のお金の増減のテスト ここまで---
  end
  
  # プレーヤーのスプリットのテスト
  # def test_player_split
  #   player = Player.new('プレーヤー')
  #   deck = Deck.new
  #   player.cards = [Card.new('スペード', 5), Card.new('ダイヤ', 5)]
  #   player.player_options(Card.new('ハート', 2))
  #   # スプリット後の２つの手札が同じかどうか
  #   assert_equal player.cards[0].number, player.cards[0].number
  #   # スプリットした手札でヒットできてるかどうか
  #   player.hit_or_stand(deck)
  # end
end