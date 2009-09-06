class WordSearch
  def initialize(*options)
  
  end
  
  def generate(width, height)
    @width = width
    @height = height
  end
  
  def to_a
    result = []
    
    @height.times do |i|
      row = []
      @width.times do |j|
        row << "."
      end
      
      result << row.join(' ')
    end
    
    return result
  end
  
  def valid?
    false
  end
end