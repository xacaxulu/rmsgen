Feature: Helper sets title
  In order to give the polnote a title
  As a helper
  I want to be asked for title text 
  and shown the proper html output

  Background:
    Given a polnote:
    """
    A story about something.
    """
    And I run rmsgen

  Scenario: Helper sets title
    When I type "I Like Turtles" 
    Then I should see a title for "I Like Turtles"

  Scenario: Helper capitalizes each word in the title
    When I type "i like turtles" 
    Then I should see a title for "I Like Turtles"

