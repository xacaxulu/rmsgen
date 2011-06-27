Feature: Helper sets title
  In order to give the polnote a title
  As a helper
  I want to be asked for title text 
  and shown the proper html output

  Scenario: Helper sets title
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    A story about something.
    """
    And I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """
    Given I run `rmsgen -c config.yml` interactively
    And I type "I Like Turtles" 
    Then the output should contain:
    """
    <p><li><a name=\"02_April_2011_(I_Like_Turtles)\" />02 April 2011 (<a class=\"titlelink\" href=\"#02_April_2011_(I_Like_Turtles)\">I Like Turtles</a>)</p>\n
    """
