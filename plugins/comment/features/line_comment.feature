Feature: Commenting lines by prefixing a comment string

  Background:
    Given insert single space after comment is disabled
    When I open a new edit tab

  Scenario: Commenting a single line
    When I replace the contents with "A piece of code"
    And I switch the language to "C"
    And I move the cursor to 5
    And I toggle comment lines
    Then the contents should be "// A pie<c>ce of code"
    When I toggle comment lines
    Then the contents should be "A pie<c>ce of code"

  Scenario: Uncommenting a single line
    When I replace the contents with "# A piece of code"
    And I switch the language to "Ruby"
    And I move the cursor to 5
    And I toggle comment lines
    Then the contents should be "A p<c>iece of code"

  Scenario: Uncommenting a single line that doesn't have the space
    When I replace the contents with "#A piece of code"
    And I switch the language to "Ruby"
    And I move the cursor to 5
    And I toggle comment lines
    Then the contents should be "A piece of code"

  Scenario: Commenting several lines
    When I replace the contents with "Two pieces\nof code"
    And I switch the language to "Ruby"
    And I select from 0 to 13
    And I toggle comment lines
    Then the contents should be "<s># Two pieces\n# of<c> code"
    When I toggle comment lines
    Then the contents should be "<s>Two pieces\nof<c> code"

  Scenario: Uncommenting several lines, not all of them have the space
    When I replace the contents with "# Two pieces\n#of code"
    And I switch the language to "Ruby"
    And I select from 0 to 16
    And I toggle comment lines
    Then the contents should be "<s>Two pieces\nof<c> code"

  Scenario: Commenting when not all the lines begin with the comment symbol
    When I replace the contents with "# foo\n# bar\nbaz"
    And I switch the language to "Ruby"
    And I select from 0 to 15
    And I toggle comment lines
    Then the contents should be "<s># # foo\n# # bar\n# baz<c>"
    When I toggle comment lines
    Then the contents should be "# foo\n# bar\nbaz"

  Scenario: Commenting a single line with the cursor on the next line
    When I replace the contents with "Two pieces\nof code"
    And I switch the language to "Ruby"
    And I select from 0 to 11
    And I toggle comment lines
    Then the contents should be "<s># Two pieces\n<c>of code"
    When I toggle comment lines
    Then the contents should be "<s>Two pieces\n<c>of code"

  Scenario: Commenting a single line with the cursor and selection point on the same line
    When I replace the contents with "Two pieces\nof code"
    And I switch the language to "Ruby"
    And I select from 3 to 0
    And I toggle comment lines
    Then the contents should be "<c># Two<s> pieces\nof code"
    When I toggle comment lines
    Then the contents should be "<c>Two<s> pieces\nof code"

  Scenario: Inserting a single space after comments when a line has no indentation
    Given insert single space after comment is enabled
    When I replace the contents with "A few\nlines\nof unindented\ncode"
    And I switch the language to "Ruby"
    And I select from 2 to 27
    And I toggle comment lines
    Then the contents should be "A <s># few\n# lines\n# of unindented\n# c<c>ode"
    When I toggle comment lines
    Then the contents should be "A <s>few\nlines\nof unindented\nc<c>ode"
    
  Scenario: Commenting an indented single line
    When I replace the contents with "  A piece of code"
    And I switch the language to "C"
    And I toggle comment lines
    Then the contents should be "  // A piece of code"
    When I toggle comment lines
    Then the contents should be "  A piece of code"

  Scenario: Commenting several lines, not from the start of one of them
    When I replace the contents with "Two pieces\nof code"
    And I switch the language to "Ruby"
    And I select from 2 to 13
    And I toggle comment lines
    Then the contents should be "Tw<s># o pieces\n# of<c> code"
    When I toggle comment lines
    Then the contents should be "Tw<s>o pieces\nof<c> code"


