Feature: Concat tabbed line
  In order to complete the sentence
  As a helper
  I must append the tabbed line to the previous paragraph

  @announce-stdout
  Scenario: Line concat
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "note" with:
    """
    Some text

    http://test.com

       Append tabbed lines
    """

    And I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """

    And I run `rmsgen -c config.yml` interactively
    And I type "The Title"

    And I type "Some"
    Then the output should contain:
    """
    The Title
    """

    Then the output should contain:
    """
    <p><a href='http://test.com'>Some</a> text Append tabbed lines</p>
    """
