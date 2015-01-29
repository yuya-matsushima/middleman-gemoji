Feature: Emoji convert

  Scenario: Load extension
    Given a fixture app "gemoji-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the output should contain "Extension: gemoji"
    And the output should not contain "Unknown Extension: gemoji"
