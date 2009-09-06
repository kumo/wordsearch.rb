require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib word_search])

class TestCountSpaces < Test::Unit::TestCase
  def setup
    @word_search = WordSearch.new
  end

  def test_single_row
    @word_search.generate(6,1)
    assert_equal @word_search.to_a[0].count('.'), 6
  end
end
