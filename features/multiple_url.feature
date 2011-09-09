Feature: Inquiring about multiple urls
  In order to efficiently respond to polnots
  As a helper
  I want to be be able to input information on multiple urls

  Scenario: It asks for a title and link text
    Given a polnote:
    """
    A story about something.

    http://test.com

    And something else

    http://test.com
    """
    Given I run rmsgen
    And I type "The Title" for the title
    And I type "something" for the link text
    And I type "something else" for the link text
    Then the output should contain:
    """
    <p>A story about <a href='http://test.com'>something</a>.</p>
    <p>And <a href='http://test.com'>something else</a></p>
    """
