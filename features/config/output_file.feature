Feature: Output file for polnotes to be written to
  In order manage the bulk polnotes easier
  As a helper
  I the polnotes to be written to a file

  Background:
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    output_file: output.html
    """

    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    A story about something.

    http://test.com
    """
    And I cd to ".."

  Scenario: Output file specified in config
    Given I run `rmsgen -c config.yml` interactively
    And I type "The Title"
    And I type "something"
    Then a file named "output.html" should exist
    When I run `cat output.html`
    Then the output should contain:
    """
    <p>A story about <a href='http://test.com'>something</a>.</p>
    """

  Scenario: Notes are appended to the file
    And I cd to "polnotes"
    And a file named "polnote2" with:
    """
    I like turtles.

    http://
    """
    And I cd to ".."
    Given I run `rmsgen -c config.yml` interactively
    And I type "The Title"
    And I type "something"
    And I type "Turtle Story"
    And I type "turtles"
    When I run `cat output.html`
    Then I should see a title for "The Title"
    And I should see a title for "Turtle Story"
    Then the output should contain:
    """
    <p>A story about <a href='http://test.com'>something</a>.</p>
    """

    Then the output should contain:
    """
    <p>I like <a href='http://'>turtles</a>.</p>
    """
