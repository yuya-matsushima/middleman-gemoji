Feature: Emoji convert under `middleman server`

  Scenario: Convert ":+1+" to emoji
    Given the Server is running at "gemoji-app"
    When I go to "/index.html"
    Then I should see:
      """
      <p><img class="gemoji" alt="+1" src="/images/emoji/unicode/1f44d.png" /></p>

      """

  Scenario: Convert content that doesn't have :emoji:
    Given the Server is running at "gemoji-app"
    When I go to "/no-emoji.html"
    Then I should see:
      """
      hoge
      """
