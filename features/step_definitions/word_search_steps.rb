Given /^there are no words$/ do
  @ws = WordSearch.new
end

Given /^there are words (.*)$/ do |words|
  @ws = WordSearch.new(words.split(','))
end

Given /^I have the grid$/ do |table|
  width = table.raw[0][0].split(' ').size
  height = table.raw.size
  
  puts "we have a #{width} by #{height} table"
  
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
  for row in @ws.to_a do
    row.count('.').should == count.to_i
  end
end