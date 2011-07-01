Feature: Enumerating notes
  In order to quickly work on notes
  As a helper
  I want to be able to answer many notes

  Scenario: Two simple notes
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    A story about something.

    http://test.com
    """

    And a file named "polnote2" with:
    """
    I like turtles.

    http://test.com
    """
    And I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """

    Given I run `rmsgen -c config.yml` interactively
    And I type "The Title"
    And I type "A story about something."
    And I type "Turtle Story"
    And I type "I like turtles."

    Then the output should contain:
    """ 
    A story about something.

    http://test.com
   
    Type title:


    A story about something.

    What is the text?
    """

    Then the output should contain:
    """ 
    I like turtles.

    http://test.com
   
    Type title:


    I like turtles.

    What is the text?
    """

    And the output should contain:
    """
    <p><a href='http://test.com'>A story about something.</a></p>
    """

    And the output should contain:
    """
    <p><a href='http://test.com'>I like turtles.</a></p>
    """

