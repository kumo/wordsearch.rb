require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestCountAvailableSpacesForString < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_empty_row
    assert_equal @word_search.available_spaces_for_string('......'), [6]
    assert_equal @word_search.available_spaces_for_string_as_hashes('......'), [{:start => 0, :length => 6}]
  end
  
  def test_count_no_space_left
    assert_equal @word_search.available_spaces_for_string('xyz'), [0]
    assert_equal @word_search.available_spaces_for_string_as_hashes('xyz'), []
  end

  def test_spaces_at_both_ends
    assert_equal @word_search.available_spaces_for_string('.red..'), [1,2]
    assert_equal @word_search.available_spaces_for_string_as_hashes('.red..'), [{:start => 0, :length => 1}, {:start => 4, :length => 2}]
  end

  def test_space_at_end_of_row
    assert_equal @word_search.available_spaces_for_string('red...'), [3]
    assert_equal @word_search.available_spaces_for_string_as_hashes('red...'), [{:start => 3, :length => 3}]
  end

  def test_space_at_start_of_row
    assert_equal @word_search.available_spaces_for_string('..red'), [2]
    assert_equal @word_search.available_spaces_for_string_as_hashes('..red'), [{:start => 0, :length => 2}]
  end
  
  def test_spaces_between_words
    assert_equal @word_search.available_spaces_for_string('...red..blue....'), [3,2,4]
    assert_equal @word_search.available_spaces_for_string_as_hashes('...red..blue....'), [{:start => 0, :length => 3}, {:start => 6, :length => 2}, {:start => 12, :length => 4}]
  end
end
