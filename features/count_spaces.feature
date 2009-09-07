Feature: counting available spaces
  As a word search generator
  I have to know how many spaces there are
  So I can drive people crazy
  
  Scenario Outline: empty grid
    Given there are no words
    When I generate a <width> by <height> word search with spaces
    Then each row should have <expected> spaces
    And the largest word for each row is <expected_row> characters
    And the largest word for each column is <expected_column> characters

  Examples:
    | width | height | expected | expected_row | expected_column |
    | 5     | 5      | 5        | 5            | 5               |
    | 1     | 1      | 1        | 1            | 1               |
    | 10    | 4      | 10       | 10           | 4               |
    
  Scenario: existing grid
    Given there are no words
    And I have the grid
      | r e d . . . |
      | . r e d . . |
      | . . . r e d |
    When I generate a 6 by 3 word search with spaces
    Then the longest word for each line should be as follows:
      | 3 |
      | 2 |
      | 3 |
    And the longest word for each column should be as follows:
      | 2 |
      | 1 |
      | 1 |
      | 1 |
      | 2 |
      | 2 |