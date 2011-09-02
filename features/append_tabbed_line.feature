@announce-stdout
@announce-stderr
Feature: Append tabbed line to previous line of text
  In order to complete the sentence
  As a helper
  I must append the tabbed line to the previous paragraph

  Scenario: When an indented line is encounterd the indented line is appended to the previous line of text.
    Given a polnote:
    """
    These are magical creatures

    http://unicorns.org

       living in a magical land...
    """
    When I run `rmsgen -c config.yml` interactively
    And I type "Magical Unicorns" for the title
    And I type "magical creatures" for the link text
    Then the output should contain:
    """
    Magical Unicorns
    """

    Then the output should contain:
    """
    <p>These are <a href='http://unicorns.org'>magical creatures</a> living in a magical land...</p>
    """
