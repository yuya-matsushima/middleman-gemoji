Feature: gemoji command

  Scenario: Copy emoji files to imaged_dir
    Given a fixture app "command-app"
    When I run `middleman gemoji`
    Then the exit status should be 0
    And I cd to "source/images/emoji"
    And the following files should exist:
      | metal.png         |
      | unicode/00a9.png  |
      | unicode/2665.png  |
      | unicode/1f600.png |
      | unicode/1f363.png |
      | unicode/1f44d.png |

  Scenario: Copy emoji files with option
    Given a fixture app "command-app"
    When I run `middleman gemoji -p img/gemoji`
    Then the exit status should be 0
    And I cd to "source/img/gemoji"
    And the following files should exist:
      | metal.png         |
      | unicode/00a9.png  |
      | unicode/2665.png  |
      | unicode/1f600.png |
      | unicode/1f363.png |
      | unicode/1f44d.png |
