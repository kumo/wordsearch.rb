require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestUsingWordLettersToFillInSpaces < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_single_letter
    @word_search.add_words(%w{r})
    @word_search.generate(3,3)
    assert_equal @word_search.letters_used, %w{R}
  end

  def test_single_word
    @word_search.add_words(%w{red})
    @word_search.generate(3,3)
    assert_equal @word_search.letters_used, %w{D E R}
  end

  def test_multiple_words
    @word_search.add_words(%w{dog cat})
    @word_search.generate(3,3)
    assert_equal @word_search.letters_used, %w{A C D G O T}
  end

  def test_repeated_letters
    @word_search.add_words(%w{ball})
    @word_search.generate(4,4)
    assert_equal @word_search.letters_used, %w{A B L}
  end
end