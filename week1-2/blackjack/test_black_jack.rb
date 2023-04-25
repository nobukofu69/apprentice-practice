require 'minitest/autorun'
require_relative 'black_jack'

class TestBlackJack < Minitest::Test
    
  def setup
    @user = User.new
    @dealer = Dealer.new
  end
  
  def test_black_jack
    @user.set_bet_amount
    @user.hand, @dealer.hand = [10, 11],[10,11]
    @user.deel
    @dealer.hit_or_stand
    @user.player_results
    assert_equal 1000, @user.money
  end
end