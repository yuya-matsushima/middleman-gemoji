Feature: Emoji convert

  Scenario: Load extension
    Given a fixture app "gemoji-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the output should contain "Extension: gemoji"
    And the output should not contain "Unknown Extension: gemoji"

  Scenario: Convert ":+1+" to emoji
    Given a fixture app "gemoji-app"
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="/images/emoji/unicode/1f44d.png" /></p>

      """

  Scenario: Convert ":+1+" to emoji with :size option
    Given a fixture app "gemoji-app"
    And a file named "config.rb" with:
      """
      activate :gemoji, :size => 20
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="/images/emoji/unicode/1f44d.png" width="20" height="20" /></p>

      """

  Scenario: Convert ":+1+" to emoji with :style option
    Given a fixture app "gemoji-app"
    And a file named "config.rb" with:
      """
      activate :gemoji, :style => "vertical-align: middle"
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="/images/emoji/unicode/1f44d.png" style="vertical-align: middle" /></p>

      """
