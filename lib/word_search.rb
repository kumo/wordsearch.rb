class WordSearch
  def initialize(words = [])
    @words = words
    @grid = []
    @invalid_words = 0
    @clobber_grid = true
  end
  
  # Helper/Tester method for pre-initialising a grid
  def add_grid(grid, width, height)
    @last_width = width
    @last_height = height
    
    @clobber_grid = false
    generate_empty_grid
    
    height.times do |i|
      @grid[i] = grid[i][0].split(' ')
    end
  end
  
  def add_words(words)
    @words << words
    @words.flatten!
  end
  
  def generate(width, height)
    @last_width = width
    @last_height = height
    
    generate_empty_grid unless !@clobber_grid
    
    @words.each do |word|
      place_word_horizontally(word.upcase)
    end
  end
  
  # Place in a word somewhere in the grid. For now it cannot place words backwards
  def place_word_horizontally(word)
    length_of_word = word.size
    
    # If the word is longer than the grid then it cannot be used
    if length_of_word > @last_width
      @invalid_words += 1
      return
    end
    
    # Simple algorithm:
    # 1. choose a row
    # 2. check if there is space on that row for the word
    # 3. choose a position
    
    possible_row = @grid[rand(@last_height)]
    
    
    
    # Since the word is of a certain length then it can be placed on a certain position
    # on a row. Basically from 0 to line length - word length
    #puts "word is #{length_of_word} and line is #{@last_width}. Position is from 0 to #{@last_width - length_of_word}"
    maximum_column = @last_width - length_of_word
    
    if maximum_column == 0
      possible_column = 0
    else
      possible_column = rand(@last_width - length_of_word)
    end
    possible_row = rand(@last_height)
    
    #puts "placing word at #{possible_column}, #{possible_row}"
    
    row = @grid[possible_row]
    length_of_word.times do |i|
      row[possible_column + i] = word[i,1]
    end
  end
  
  def to_a
    result = []
    
    for row in @grid do
      result << row.join(' ')
    end
    
    return result
  end
  
  def valid?
    @invalid_words == 0 && @last_height > 0 && @last_width > 0
  end
  
  def generate_empty_grid
    @grid = []
    @last_height.times do |i|
      row = []
      @last_width.times do |j|
        row << "."
      end
      
      @grid << row
    end
  end
end