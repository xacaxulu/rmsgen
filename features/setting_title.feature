Feature: Helper sets title
  In order to give the polnote a title
  As a helper
  I want to be asked for title text 
  and shown the proper html output

  Scenario: Helper sets title
    Given a polnote:
    """
    A story about something.
    """

    When I run rmsgen
    And I type "I Like Turtles" 
    Then I should see a title for "I Like Turtles"
