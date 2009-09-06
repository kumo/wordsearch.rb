Feature: counting available spaces
  As a word search generator
  I have to know how many spaces there are
  So I can drive people crazy
  
  Scenario Outline: empty row
    Given there are no words
    When I generate a <width> by <height> word search
    Then each row should have <expected> spaces
    And the largest word for each row is <expected_length> characters

  Examples:
    | width | height | expected | expected_length |
    | 5     | 5      | 5        | 5               |
    | 1     | 1      | 1        | 1               |
    | 10    | 4      | 10       | 10              |
    
  Scenario: existing grid
    Given there are no words
    And I have the grid
      | r e d . . . |
      | . r e d . . |
      | . . . r e d |
    When I generate a 6 by 3 word search
    Then the longest word for each line should be as follows:
      | 3 |
      | 2 |
      | 3 |