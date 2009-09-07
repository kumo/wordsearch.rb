require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestGenerateAvailableHorizontalPositions < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end
  
  def test_word_too_long
    assert_equal @word_search.positions_for_word_in_string("superlong", "...."), []
  end
  
  def test_word_same_length
    assert_equal @word_search.positions_for_word_in_string("same", "...."), [0]
  end

  def test_word_different_length
    assert_equal @word_search.positions_for_word_in_string("same", "........"), [0,1,2,3,4]
  end

  def test_multiple_correct_spaces
    assert_equal @word_search.positions_for_word_in_string("same", "....XX...."), [0,6]
  end

  def test_multiple_spaces
    assert_equal @word_search.positions_for_word_in_string("cat", "....XX..YY...Z..."), [0,1,10,14]
  end
end