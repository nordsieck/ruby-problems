require_relative "heap"
require "test/unit"

class TestHeap < Test::Unit::TestCase
  class C end # not comparable

  def test_heap_raw
    h = Heap.new
    assert_equal(h.raw(), [])

    for i in 1..3 do h.push(i) end
    assert_equal(h.raw(), [1, 2, 3])
  end
  
  def test_heap_push
    h = Heap.new
    assert_nothing_thrown { h.push(1) }
    assert_nothing_thrown { h.push(2) }
    assert_raise(ArgumentError) { h.push("a") }

    h = Heap.new
    assert_raise(ArgumentError) { h.push(C.new) }

    h = Heap.new
    for i in 4.downto(0) do h.push(i) end
    assert_equal(h.raw, [0, 1, 3, 4, 2])

    #max
    h = Heap.new(false)
    for i in 0..4 do h.push(i) end
    assert_equal([4, 3, 1, 0, 2], h.raw)
  end

  def test_heap_size
    h = Heap.new
    assert_equal(h.size, 0)

    h.push(1)
    assert_equal(h.size, 1)
  end

  def test_heap_is_empty
    h = Heap.new
    assert_equal(h.is_empty?, true)

    h.push(1)
    assert_equal(h.is_empty?, false)
  end

  def test_heap_pop
    h = Heap.new
    assert_equal(nil, h.pop)
    
    h.push(1)
    assert_equal(1, h.size)

    val = h.pop
    assert_equal(0, h.size)
    assert_equal(1, val)

    h = Heap.new(true, 1, 2, 5, 3, 4, 6, 7)
    
    val = h.pop
    assert_equal(1, val)
    assert_equal([2, 3, 5, 7, 4, 6], h.raw)

    h = Heap.new(false)
    for i in 0..4 do h.push(i) end
    assert_equal([4, 3, 1, 0, 2], h.raw)
    val = h.pop
    assert_equal(4, val)
    assert_equal([3, 2, 1, 0], h.raw)
  end

  def test_heap_initialize
    # min/max

    h = Heap.new
    h.push(0)
    h.push(1)
    assert_equal([0, 1], h.raw)

    h = Heap.new(false)
    h.push(0)
    h.push(1)
    assert_equal([1, 0], h.raw)

    # initial values
    h = Heap.new(true, 0, 1, 2, 3, 4)
    assert_equal([0, 1, 2, 3, 4], h.raw)

    h = Heap.new(false, 0, 1, 2, 3, 4)
    assert_equal([4, 3, 1, 0, 2], h.raw)
  end
end
