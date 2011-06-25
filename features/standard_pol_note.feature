@announce-stdout
@announce-stderr
Feature: Managing a standard polnote
  In order to obtain a polnote in html
  As a user
  I want to run polnote on a standard polnote

  Scenario: An easy polnote 
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    30 Saudi women held their drive-in, but the police responded by not taking notice.

    http://www.guardian.co.uk/world/2011/jun/17/saudi-arabia-women-drivers-protest
    """
    And I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """
    Given I run `rmsgen -c config.yml` interactively
    And I type "women held their"
    Then the output should contain:
    """ 
    What is the text?
    """

    Then the output should contain:
    """
    30 Saudi <a href='http://www.guardian.co.uk/world/2011/jun/17/saudi-arabia-women-drivers-protest'>women held their</a> drive-in, but the police responded by not taking notice.
    """
