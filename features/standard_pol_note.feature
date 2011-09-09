Feature: Managing a standard polnote
  In order to obtain a polnote in html
  As a user
  I want to run polnote on a standard polnote

  @setup_polnote_directory
  Scenario: A standard polnote 
    Given a polnote:
    """
    A story about something.

    http://test.com
    """
    Given I run rmsgen
    And I type "The Title" for the title
    And I type "something" for the link text

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
