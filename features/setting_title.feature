Feature: Helper sets title
  In order to give the polnote a title
  As a helper
  I want to be asked for title text 
  and shown the proper html output

  @setup_polnote_directory
  Scenario: Helper sets title
    Given a file named "polnote" with:
    """
    A story about something.
    """

    And I cd to ".."
    And a file named "config.yml" with:
    """
    email_dir: polnotes
    """

    When I run `rmsgen -c config.yml` interactively
    And I type "I Like Turtles" 
    Then I should see a title for "I Like Turtles"
