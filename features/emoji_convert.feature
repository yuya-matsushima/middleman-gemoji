Feature: Emoji convert

  Scenario: Convert ":+1:" to img tag
    Given a fixture app "gemoji-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0
    Then the output should not contain "Unknown Extension: gemoji"
