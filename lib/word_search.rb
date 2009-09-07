class WordSearch
  def initialize(words = [])
    @words = words
    @grid = []
    @invalid_words = 0
    @clobber_grid = true
    @letters_used = []
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
  
  def generate(width, height, should_fill_empty_spaces=true)
    @last_width = width
    @last_height = height
    
    generate_empty_grid unless !@clobber_grid
    
    @words.each do |word|
      place_word_horizontally(word.upcase)
    end
    
    fill_empty_spaces if should_fill_empty_spaces
    
    valid?
  end
  
  def generate_with_spaces(width, height)
    generate(width, height, false)
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
    
    checked_rows = Array.new(@last_height) {|i| 0}
    
    while (checked_rows.inject(0) { |s,v| s += v } < checked_rows.size) do
      possible_row_position = rand(@last_height)
      possible_row = @grid[possible_row_position]
    
      if maximum_word_length_for_string(possible_row.join) >= word_length
        possible_col_positions = positions_for_word_in_string(word, possible_row.join)
        col_position = possible_col_positions[rand(possible_col_positions.size)]
        word_length.times do |i|
          possible_row[col_position + i] = word[i,1]
        end
        
        remember_used_letters(word)

        return
      else
        #puts "skipping row #{possible_row_position}"
      end
      checked_rows[possible_row_position] = 1
    end
    
    # shouldn't be here so word was invalid
    @invalid_words += 1
  end
  
  def to_a
    return @grid
  end

  def to_strings
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

  def available_spaces_for_column(i)
    column = @grid.collect {|row| row[i]}.join
    available_spaces_for_string(column)
  end
  
  def available_spaces_for_string(str)
    spaces = str.scan(/\.+/).map{|group| group.size}

    spaces == [] ? [0] : spaces
  end

  def available_spaces_for_string_as_hashes(str)
    spaces = []
    in_a_space = false
    length = 0
    start = 0
    str.split('').each_with_index {|char, index|
      if char == '.'
        if in_a_space
          length += 1
        else
          in_a_space = true
          start = index
          length = 1
        end
      else
        if in_a_space # save existing one
          in_a_space = false
          spaces << {:start => start, :length => length}
        end
      end
    }
    
    if in_a_space
      spaces << {:start => start, :length => length}
    end
    
    spaces
  end
  
  def maximum_word_length_for_row(i)
    spaces = available_spaces_for_row(i)
    spaces.sort[-1]
  end

  def maximum_word_length_for_column(i)
    spaces = available_spaces_for_column(i)
    spaces.sort[-1]
  end

  def maximum_word_length_for_string(str)
    spaces = available_spaces_for_string(str)
    spaces.sort[-1]
  end
  
  def remember_used_letters(word)
    @letters_used << word.split('')
  end
  
  def letters_used
    @letters_used.flatten.sort.uniq
  end
  
  def fill_empty_spaces
    letters_to_choose_from = letters_used
    
    @grid.each do |row|
      row.collect! {|char| char == '.' ? letters_to_choose_from[rand(letters_to_choose_from.size)] : char} 
      #row.each do |char|
      #  puts "char is #{char}"
      #  if char == '.'
      #    char = letters_to_choose_from[rand(letters_to_choose_from.size)] if char == '.'
      #    puts "choosing random letter #{char}"
      #  else
      #    puts "skipping #{char}"
      #  end
      #end
    end
  end
  
  def positions_for_word_in_string(word, string)
    return [] if word.size > string.size or maximum_word_length_for_string(word) > string.size
    # 1. if the word is bigger than the string then we cannot do anything
    # 2. if the word is the same length as the string then only one position
    # 3. if the word is shorter than the string then string length - word length positions
    #    e.g. fish in  ...... (6) can go fish.., .fish., ..fish (6-4+1)
    # 4. if there are multiple spaces then each space must be checked
    #    e.g. cat in ..dog...cow.... can go ..dogCATcow...., ..dog...cowCAT., ..dog...cow.CAT 
    
    spaces = available_spaces_for_string_as_hashes(string)
    positions = []
    
    spaces.each do |space|
      if space[:length] > word.size
        space[:start].upto(space[:length] - word.size) do |i|
          positions << space[:start] + i
        end
      elsif space[:length] == word.size
        positions << space[:start]
      end
    end
    
    positions
  end
end