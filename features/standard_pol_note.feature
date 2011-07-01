@announce-stdout
@announce-stderr
Feature: Managing a standard polnote
  In order to obtain a polnote in html
  As a user
  I want to run polnote on a standard polnote

  Scenario: A standard polnote 
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    A story about something.

    http://test.com
    """
    And I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """
    Given I run `rmsgen -c config.yml` interactively
    And I type "The Title"
    And I type "something"

    Then the output should contain:
    """ 
    A story about something.

    http://test.com
   
    Type title:

    A story about something.

    What is the text?
    """

    Then I should see a title for "The Title"
    Then the output should contain:
    """
    <p>A story about <a href='http://test.com'>something</a>.</p>
    """
