Feature: Emoji convert with no emoji files

  Scenario: Convert ":+1+" to emoji
    Given a fixture app "gemoji-empty-app"
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png" /></p>

      """

  Scenario: Convert ":+1+" to emoji with :size option
    Given a fixture app "gemoji-empty-app"
    And a file named "config.rb" with:
      """
      activate :gemoji, :size => 20
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png" width="20" height="20" /></p>

      """

  Scenario: Convert ":+1+" to emoji with :style option
    Given a fixture app "gemoji-empty-app"
    And a file named "config.rb" with:
      """
      activate :gemoji, :style => "vertical-align: middle"
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png" style="vertical-align: middle" /></p>

      """

  Scenario: Convert ":+1+" to emoji with :emoji_dir option
    Given a fixture app "gemoji-empty-app"
    And a file named "config.rb" with:
      """
      activate :gemoji, :emoji_dir => "img/emoji"
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png" /></p>

      """

  Scenario: Convert ":+1+" to emoji with :emoji_dir option and app.config.http_prefix
    Given a fixture app "gemoji-empty-app"
    And a file named "config.rb" with:
      """
      set :http_prefix, "http://localhost:4567"
      activate :gemoji, :emoji_dir => "img/emoji"
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the html in "build/index.html" should contain:
      """
      <p><img alt="+1" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png" /></p>

      """
