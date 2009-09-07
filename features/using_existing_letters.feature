Feature: existing letters
  When I create a word search
  I should probably only use letters from the words
  So that it is more difficult
  
  Scenario: single letter
    Given there are words r
    When I generate a 4 by 3 word search
    Then I should see the following word search:
      | R R R R |
      | R R R R |
      | R R R R |

  Scenario: single word
    Given there are words red
    When I generate a 4 by 3 word search
    Then the word search should match the following:
      | [DER] | [DER] | [DER] | [DER] |
      | [DER] | [DER] | [DER] | [DER] |
      | [DER] | [DER] | [DER] | [DER] |

  Scenario: multiple words
    Given there are words red,orb,dog
    When I generate a 4 by 3 word search
    Then the word search should match the following:
      | [BDEGOR] | [BDEGOR] | [BDEGOR] | [BDEGOR] |
      | [BDEGOR] | [BDEGOR] | [BDEGOR] | [BDEGOR] |
      | [BDEGOR] | [BDEGOR] | [BDEGOR] | [BDEGOR] |
