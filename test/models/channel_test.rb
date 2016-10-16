require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  def setup
    @channel = channels(:one)
  end

  test "channel has correct number of ripples" do
    assert_equal @channel.ripples.count, 4
  end

  test "last ripple is earliest" do
    assert_equal @channel.ripples.last, ripples(:a1)
  end

  test "first ripple is latest" do
    assert_equal @channel.ripples.first, ripples(:a3)
  end

  test "current ripple for key" do
    a3 = ripples(:a3)
    a_key = ripples(:a1).key_id
    assert_equal 3, @channel.ripples.by_key(a_key).count
    assert_equal a3, @channel.ripples.current_by_key(a_key)
  end
end
