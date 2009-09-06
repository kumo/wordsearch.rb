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
  
  Scenario: forced position
    Given there are words horrible
    When I generate a 8 by 1 word search
    Then I should see the following word search:
      | H O R R I B L E |

  Scenario: invalid size
    Given there are words fishcakes,purple
    When I generate a 1 by 5 word search
    Then the word search should not be valid