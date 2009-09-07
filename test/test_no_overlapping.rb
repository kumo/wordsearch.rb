require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestNoOverlapping < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_single_row
    @word_search.add_words(["RED"])
    @word_search.add_grid([['r e d . . .']], 6, 1)
    
    @word_search.generate(6,1)
    assert_equal [%w{r e d R E D}], @word_search.to_a
    assert_equal true, @word_search.valid?
  end

  def test_multiple_rows
    @word_search.add_words(["RED", "RED"])
    @word_search.add_grid([['r e d . . .'], ['. . . r e d']], 6, 2)
    
    @word_search.generate(6,2)
    assert_equal [%w{r e d R E D}, %w{R E D r e d}], @word_search.to_a
    assert_equal true, @word_search.valid?
  end

end
