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
    When I generate a 4 by 3 word search
    Then I should see the following word search:
      | . . . . |
      | . . . . |
      | . . . . |
  
  Scenario: forced position
    Given there are words longword
    When I generate a 8 by 1 word search
    Then I should see the following word search:
      | L O N G W O R D |

  @wip
  Scenario: no overlapping
    Given there are words red
    And I have the grid
      | r e d . . . |
    When I generate a 6 by 1 word search
    Then I should see the following word search:
      | r e d R E D |
  
  Scenario: not enough space
    Given there are words purple
    And I have the grid
      | r e d . . . |
    When I generate a 6 by 1 word search
    Then I should see the following word search:
      | r e d . . . |
    And the word search should not be valid
      
  Scenario: invalid size
    Given there are words longlonglongword,evenmuchlongerthanbeforeword
    When I generate a 1 by 5 word search
    Then the word search should not be valid