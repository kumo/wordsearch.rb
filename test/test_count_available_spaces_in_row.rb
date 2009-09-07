require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestCountAvailableSpacesInRow < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_empty_row
    @word_search.generate(6,6)
    assert_equal @word_search.available_spaces_for_row(0), [6]
  end
  
  def test_count_no_space_left
    @word_search.add_grid([['r e d r e d']], 6, 1)
    @word_search.generate(6,6)
    assert_equal @word_search.available_spaces_for_row(0), [0]
  end

  def test_spaces_at_both_ends
    @word_search.add_grid([['. r e d . .']], 6, 1)
    @word_search.generate(6,6)
    assert_equal @word_search.available_spaces_for_row(0), [1,2]
  end

  def test_space_at_end_of_row
    @word_search.add_grid([['r e d . . .']], 6, 1)
    @word_search.generate(6,6)
    assert_equal @word_search.available_spaces_for_row(0), [3]
  end

  def test_space_at_start_of_row
    @word_search.add_grid([['. . . r e d']], 6, 1)
    @word_search.generate(6,6)
    assert_equal @word_search.available_spaces_for_row(0), [3]
  end
  
  def test_spaces_between_words
    @word_search.add_grid([['. . . r e d . . b l u e . . . .']], 16, 1)
    @word_search.generate(16,16)
    assert_equal @word_search.available_spaces_for_row(0), [3,2,4]
  end
end
