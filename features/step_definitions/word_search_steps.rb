Given /^there are no words$/ do
  @ws = WordSearch.new
end

Given /^there are words (.*)$/ do |words|
  @ws = WordSearch.new(words.split(','))
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

