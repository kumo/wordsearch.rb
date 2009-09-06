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
    word_length = word.size
    
    # If the word is longer than the grid then it cannot be used
    if word_length > @last_width
      @invalid_words += 1
      return
    end
    
    # Simple algorithm:
    # 1. choose a row
    # 2. check if there is space on that row for the word
    # 3. choose a position
    
    checks = Array.new(@last_height) {|i| 0}
    
    while (checks.inject(0) { |s,v| s += v } < checks.size) do
      possible_row_position = rand(@last_height)
      possible_row = @grid[possible_row_position]
    
      if maximum_word_length_for_string(possible_row.join) >= word_length
        #puts "row #{possible_row_position} looks fine (#{possible_row})"
        
        # need to find where to put it
        column = -1
        possible_row.each_with_index {|char, index|
          if char == '.'
            column = index if column == -1
          end
        }
        word_length.times do |i|
          possible_row[column + i] = word[i,1]
        end

        return
      else
        #puts "skipping row #{possible_row_position}"
      end
      checks[possible_row_position] = 1
    end
    
    # shouldn't be here so word was invalid
    @invalid_words += 1
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
  
  def height
    @last_height
  end
  
  def width
    @last_width
  end
  
  def available_spaces_for_row(i)
    row = @grid[i].join
    available_spaces_for_string(row)
  end
  
  def available_spaces_for_string(str)
    spaces = str.scan(/\.+/).map{|group| group.size}

    spaces == [] ? [0] : spaces
  end
  
  def maximum_word_length_for_row(i)
    spaces = available_spaces_for_row(i)
    spaces.sort[-1]
  end

  def maximum_word_length_for_string(str)
    spaces = available_spaces_for_string(str)
    spaces.sort[-1]
  end
end