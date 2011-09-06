Feature: Detect link to polnotes
  In order to reference related polnotes
  As a helper
  I want to be prompted for a polnote url

  Scenario: A pol note with a request to find a link
    Given a polnote:
    """
    There was a unicorn search party sent out last night.

    [Link to the search party site]

    I hope the unicorn can be found!
    """
    When I run rmsgen
    And I type "The Lost Unicorn" for the title
    And I type "http://unicornsearchparty.org" for the url
    And I type "search party" for the link text
    Then the output should contain:
    """
    What is the Link to the search party site?:
    """
    And the output should contain:
    """
    There was a unicorn search party sent out last night.
    
    What is the text?
    """

    And the output should contain:
    """
    <p>There was a unicorn <a href='http://unicornsearchparty.org'>search party</a> sent out last night.</p>
    """

    And the output should contain:
    """
    <p>I hope the unicorn can be found!</p>
    """
