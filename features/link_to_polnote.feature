Feature: Detect link to polnotes
  In order to reference related polnotes
  As a helper
  I want to be prompted for a polnote url

  Scenario: A pol note with a request to link to pol note
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    A story about something.

    [Link to the pol note]

    More text
    """

    Given I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """

    Given I run `rmsgen -c config.yml` interactively
    And I type "The Title"
    And I type "http://"
    And I type "about"

    Then the output should contain:
    """
    Link to the pol note:

    """
    And the output should contain:
    """
    <p>A story <a href='http://'>about</a> something.</p>
    """

    And the output should contain:
    """
    <p>More text</p>
    """
