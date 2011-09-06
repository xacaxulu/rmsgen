Feature: Enumerating notes
  In order to quickly work on notes
  As a helper
  I want to be able to answer many notes

  Scenario: Two simple notes
    Given a polnote:
    """
    The last unicorn has been found.

    http://lostunicorns.org
    """
    Given I cd to "polnotes"
    And a file named "polnote2" with:
    """
    The unicorn search party comes to a close.

    http://searchparty.org
    """
    And I cd to ".."
    Given I run rmsgen
    And I type "Unicorn Found!" for the title
    And I type "has been found." for the link text
    And I type "Party Over"
    And I type "comes to a close."
    Then the output should contain:
    """ 
    The last unicorn has been found.

    http://lostunicorns.org
   
    """
    And the output should contain:
    """
    Unicorn Found!
    """
    And the output should contain:
    """
    <p>The last unicorn <a href='http://lostunicorns.org'>has been found.</a></p>
    """
    Then the output should contain:
    """ 
    The unicorn search party comes to a close.

    http://searchparty.org
    """
    And the output should contain:
    """
    Party Over
    """
    And the output should contain:
    """
    <p>The last unicorn <a href='http://lostunicorns.org'>has been found.</a></p>
    """
