require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestLongestWordInRow < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_empty_row
    @word_search.generate_with_spaces(6,6)
    assert_equal @word_search.maximum_word_length_for_row(0), 6
    assert_equal @word_search.maximum_word_length_for_row(1), 6
    assert_equal @word_search.maximum_word_length_for_row(2), 6
    assert_equal @word_search.maximum_word_length_for_row(3), 6
    assert_equal @word_search.maximum_word_length_for_row(4), 6
    assert_equal @word_search.maximum_word_length_for_row(5), 6
  end
  
  def test_count_no_space_left
    @word_search.add_grid([['r e d'],['r e d'],['r e d']], 3, 3)
    @word_search.generate_with_spaces(3,3)
    assert_equal @word_search.maximum_word_length_for_row(0), 0
    assert_equal @word_search.maximum_word_length_for_row(1), 0
    assert_equal @word_search.maximum_word_length_for_row(2), 0
  end

  def test_spaces_at_both_ends
    @word_search.add_grid([['. . .'], ['r r r'], ['. . .']], 3, 3)
    @word_search.generate_with_spaces(3,3)
    assert_equal @word_search.maximum_word_length_for_row(0), 3
    assert_equal @word_search.maximum_word_length_for_row(1), 0
    assert_equal @word_search.maximum_word_length_for_row(2), 3
  end

  def test_space_at_end_of_row
    @word_search.add_grid([['r . .'], ['e . .'], ['d . .']], 3, 3)
    @word_search.generate_with_spaces(3,3)
    assert_equal @word_search.maximum_word_length_for_row(1), 2
    assert_equal @word_search.maximum_word_length_for_row(2), 2
    assert_equal @word_search.maximum_word_length_for_row(0), 2
  end

  def test_space_at_start_of_row
    @word_search.add_grid([['. . r'], ['. . e'], ['. . d']], 3, 3)
    @word_search.generate_with_spaces(3,3)
    assert_equal @word_search.maximum_word_length_for_row(0), 2
    assert_equal @word_search.maximum_word_length_for_row(1), 2
    assert_equal @word_search.maximum_word_length_for_row(2), 2
  end
  
  def test_spaces_between_words
    @word_search.add_grid([['b . . p'], ['l . . i'], ['u . . n'], ['e . .k']], 4, 4)
    @word_search.generate_with_spaces(4,4)
    assert_equal @word_search.maximum_word_length_for_row(0), 2
    assert_equal @word_search.maximum_word_length_for_row(1), 2
    assert_equal @word_search.maximum_word_length_for_row(2), 2
    assert_equal @word_search.maximum_word_length_for_row(3), 2
  end
end
