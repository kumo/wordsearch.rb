Given /^there are no words$/ do
  @words = []
end

Given /^there are words (.*)$/ do |words|
  @words = []
  words.split(',').each do |word|
    @words << word
  end
end

When /^I generate a (\d+) by (\d+) word search$/ do |x, y|
  pending
end

Then /^I should see the following word search:$/ do |table|
  # table is a Cucumber::Ast::Table
  #p table.raw 
  pending
end

Then /^I should see an error$/ do
  pending
end
