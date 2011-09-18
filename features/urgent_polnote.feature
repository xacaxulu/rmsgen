Feature: Urgent Polnotes
  In order to efficiently obtain the urgnent polnote html
  As a helper
  I want to see the html output for the polnote section
  and for the urgent section

  Scenario: I see the html for the polnote section
    Given I am ready to do polnotes
    Given an urgent polnote exists
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """
    Given I run rmsgen

    When I type "Urgent Note" for the title
    And I type "01 July 2011" 
    And I type "tell" for the link text

    Then I should see a title for "Urgent Note"
    And the output should contain:
    """
    What day does it expire? 
    """
    Then the output should not contain:
    """
    <p>For one week:</p>
    """
