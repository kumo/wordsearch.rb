require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestEmptyGrid < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_no_grid
    @word_search.generate(0,0)
    assert_equal [], @word_search.to_a
    assert_equal false, @word_search.valid?
  end

  def test_square_grid
    @word_search.generate(3,3)
    assert_equal [". . .",". . .", ". . ."], @word_search.to_a
  end

  def test_rect_grid
    @word_search.generate(5,2)
    assert_equal [". . . . .",". . . . ."], @word_search.to_a
  end
end
