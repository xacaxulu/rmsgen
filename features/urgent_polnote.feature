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
    And I type "Urgent Note"
    And I type "July 1"
    And I type "tell"

    Then the output should not contain:
    """
    <p>For one week:</p>
    """

    And the output should contain:
    """
    <!-- Expires July 1 -->
    <p><li><a name='01_July_2011_(Urgent_Note)' />01 July 2011 (<a class='titlelink' href='#01_July_2011_(Urgent_Note)'>Urgent Note</a>)</p>
    <p>US citizens: <a href='http://'>tell</a> Obama to stand firm against Republican demands for raising the debt ceiling.</p>
    <p>Once in a while, when enough people demand it, Obama does what he ought to do.</p>
    """

    And the output should contain:
    """
    What day does it expire? 
    """
