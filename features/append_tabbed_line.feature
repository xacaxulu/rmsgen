Feature: Append tabbed line to previous line of text
  In order to complete the sentence
  As a helper
  I must append the tabbed line to the previous line of text

  Scenario: When an indented line is found, appended the line to the previous line of text.
    Given a polnote:
    """
    These are magical creatures

       living in a magical land.
    """
    When I run rmsgen
    And I type "Magical Unicorns" for the title
    Then the output should contain:
    """
    Magical Unicorns
    """

    Then the output should contain:
    """
    These are magical creatures living in a magical land.
    """
