require_relative "380"
require "test/unit"

class TestSmorse < Test::Unit::TestCase
  def test_smorse
    assert_equal("...---...", smorse("sos"))
    assert_equal("-...-...-..-.--", smorse("daily"))
    assert_equal(".--..-.-----..-..-----..-.", smorse("programmer"))
    assert_equal("-.....-...", smorse("bits"))
    assert_equal("-.....-...", smorse("three"))
  end
end

class TestTrie < Test::Unit::TestCase
  def test_node
    assert_equal(Trie::Node::Dot, 0)
    assert_equal(Trie::Node::Dash, 1)
  end
end
