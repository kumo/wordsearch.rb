Given /^there are no words$/ do
  @ws = WordSearch.new
end

Given /^there are words (.*)$/ do |words|
  @ws = WordSearch.new(words.split(','))
end

Given /^I have the grid$/ do |table|
  width = table.raw[0][0].split(' ').size
  height = table.raw.size
  
  #puts "we have a #{width} by #{height} table"
  
  @ws.add_grid(table.raw, width, height)
end

When /^I generate a (\d+) by (\d+) word search$/ do |x, y|
  @ws.generate(x.to_i, y.to_i)
end

Then /^I should see the following word search:$/ do |table|
  # table is a Cucumber::Ast::Table
  #p table.raw 
  table.diff!(@ws.to_a)
end

Then /^the word search should not be valid$/ do
  return @ws.valid?
end

Then /^each row should have (\d+) spaces$/ do |count|
  @ws.height.times do |i|
    @ws.available_spaces_for_row(i).should == [count.to_i]
  end
end

Then /^the largest word for each row is (\d+) characters$/ do |count|
  @ws.height.times do |i|
    @ws.maximum_word_length_for_row(i).should == count.to_i
  end
end

Then /^the longest word for each line should be as follows:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.raw.size.times do |i|
    row = table.raw[i]
    @ws.maximum_word_length_for_row(i).should == row[0].to_i
  end
end

Then /^the largest word for each column is (\d+) characters$/ do |count|
  @ws.width.times do |i|
    @ws.maximum_word_length_for_column(i).should == count.to_i
  end
end

Then /^the longest word for each column should be as follows:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.raw.size.times do |i|
    values = table.raw[i]
    @ws.maximum_word_length_for_column(i).should == values[0].to_i
  end
end

