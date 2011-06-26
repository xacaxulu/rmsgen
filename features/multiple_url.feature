Feature: Inquiring about multiple urls
  In order to efficiently respond to polnots
  As a helper
  I want to be be able to input information on multiple urls

  Scenario: Two urls
    Given a directory named "polnotes"
    Given I cd to "polnotes"
    And a file named "polnote" with:
    """
    A story about something.

    http://test.com

    And something else

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
    And I type "something"
    Then the output should contain:
    """
    <p>A story about <a href='http://test.com'>something</a>.</p>
    <p>And <a href='http://test.com'>something</a> else</p>
    """
