Feature: counting available spaces
  As a word search generator
  I have to know how many spaces there are
  So I can drive people crazy
  
  Scenario Outline: empty row
    Given there are no words
    When I generate a <width> by <height> word search
    Then each row should have <expected> spaces

  Examples:
    | width | height | expected |
    | 5     | 5      | 5        |
    | 1     | 1      | 1        |
    | 10    | 4      | 10       |