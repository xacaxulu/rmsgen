Feature: Urgent Polnotes
  In order to efficiently obtain the urgnent polnote html
  As a helper
  I want to see the html output for the polnote section
  and for the urgent section

  @announce-stderr
  Scenario: I see the html for the polnote section
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    Given an urgent polnote exists
    And I cd to ".."
    Given a file named "config.yml" with:
    """
    email_dir: polnotes
    """
    Given I run `rmsgen -c config.yml` interactively
    When I type "Urgent Note"
    And I type "01 July 2011"
    And I type "tell"

    Then I should see a title for "Urgent Note"
    And the output should contain:
    """
    What day does it expire? 
    """

    And the output should contain:
    """
    <!-- Expires 01 July 2011 -->
    """

    Then the output should not contain:
    """
    <p>For one week:</p>
    """



