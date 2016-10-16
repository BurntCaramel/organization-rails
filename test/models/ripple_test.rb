require 'test_helper'
require 'securerandom'

class RippleTest < ActiveSupport::TestCase
  def setup
    @channel = channels(:one)
    @ripple = @channel.ripples.build(info: { 'kind' => 'text' })
  end

  test "should be valid" do
    assert @ripple.valid?
  end

  test "key_id should be present" do
    @ripple.key_id = nil
    assert_not @ripple.valid?
  end

  test "info should be present" do
    @ripple.info = nil
    assert_not @ripple.valid?
  end

  test "kind should match" do
    assert_equal :text, @ripple.kind
  end

  test "name successor should be valid with same key" do
    a3 = ripples(:a3)

    new_info = {
      'name' => 'Hello'
    }
    a4 = a3.succeed_with(new_info)
    assert_equal a3.key_id, a4.key_id
    assert_equal new_info, a4.info
    assert_equal 'Hello', a4.name
    assert_not a4.deleted?
    assert a4.validate!
  end

  test "delete successor should be valid with same key" do
    a3 = ripples(:a3)

    new_info = {
      'delete' => true
    }
    a4 = a3.succeed_with(new_info)
    assert_equal a3.key_id, a4.key_id
    assert_equal new_info, a4.info
    assert a4.deleted?
    assert a4.validate!
  end
end
