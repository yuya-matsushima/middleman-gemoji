Feature: Emoji convert in Markdown

  Scenario: Convert ":+1+" to emoji
    Given a fixture app "haml-app"
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should not contain "<p>:+1:</p>"
    And the file "build/index.html" should contain:
      """
      <title>something title :+1:</title>
      """
    And the file "build/index.html" should contain:
      """
      <p><img class="gemoji" alt="+1" src="/images/emoji/unicode/1f44d.png" /></p>

      """

  Scenario: Convert content that doesn't have :emoji:
    Given a fixture app "haml-app"
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should contain:
      """
      <title>something title :+1:</title>
      """
    And the file "build/no-emoji.html" should contain:
      """
      <p>hoge</p>
      """

  Scenario: Convert ":+1+" to emoji under `middleman server`
    Given the Server is running at "haml-app"
    When I go to "/index.html"
    Then I should see '<p><img class="gemoji" alt="+1" src="/images/emoji/unicode/1f44d.png" /></p>'

  Scenario: Convert content that doesn't have :emoji: under `middleman server`
    Given the Server is running at "haml-app"
    When I go to "/no-emoji.html"
    Then I should see '<p>hoge</p>'
