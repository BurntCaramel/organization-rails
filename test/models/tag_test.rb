require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "lowercase name" do
    tag = Tag.create(name: 'Hello')
    assert_equal tag.name, 'hello'
  end
end
