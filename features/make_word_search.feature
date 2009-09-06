Feature: making a wordsearch
  As a word search generator
  I need to make one
  So that it can be used
  
  Scenario: no words specified
    Given there are no words
    When I generate a 5 by 5 word search
    Then I should see the following word search:
      | . . . . . |
      | . . . . . |
      | . . . . . |
      | . . . . . |
      | . . . . . |

  Scenario: non-square grid
    Given there are no words
    When I generate a 5 by 3 word search
    Then I should see the following word search:
      | . . . . . |
      | . . . . . |
      | . . . . . |

  Scenario: invalid size
    Given there are words fishcakes,purple
    When I generate a 1 by 5 word search
    Then I should see an error