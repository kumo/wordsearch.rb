require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestLongestWordInColumn < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_empty_column
    @word_search.generate(6,6)
    assert_equal @word_search.maximum_word_length_for_column(0), 6
  end
  
  def test_count_no_space_left
    @word_search.add_grid([['r e d'],['r e d'],['r e d']], 3, 3)
    @word_search.generate(3,3)
    assert_equal @word_search.maximum_word_length_for_column(0), 0
  end

  def test_spaces_at_both_ends
    @word_search.add_grid([['. . .'], ['r r r'], ['. . .']], 3, 3)
    @word_search.generate(3,3)
    assert_equal @word_search.maximum_word_length_for_column(0), 1
  end

  def test_space_at_end_of_column
    @word_search.add_grid([['r e d'], ['. . .'], ['. . .']], 3, 3)
    @word_search.generate(3,3)
    assert_equal @word_search.maximum_word_length_for_column(0), 2
  end

  def test_space_at_start_of_column
    @word_search.add_grid([['. . .'], ['. . .'], ['r e d']], 3, 3)
    @word_search.generate(3,3)
    assert_equal @word_search.maximum_word_length_for_column(0), 2
  end
  
  def test_spaces_between_words
    @word_search.add_grid([['b l u e'], ['. . . .'], ['b l u e'], ['. . . .']], 4, 4)
    @word_search.generate(4,4)
    assert_equal @word_search.maximum_word_length_for_column(0), 1
  end
end
