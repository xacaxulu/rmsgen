Feature: Reading configuration file
  In order to store configuration settings
  As a user
  I want to have a config file

  @announce-stdout
  @announce-stderr
  Scenario: User points email directory to nonexisting directory
    Given a file named "config.yml" with:
      """
      email_dir: foo
      """
    And I run `rmsgen -c config.yml`
    Then the output should contain "No such file or directory - foo"
    Then the exit status should be 1

  Scenario: User points email directory to existing directory
    Given a directory named "foo"
    Given a file named "config.yml" with:
      """
      email_dir: foo
      """
    And I run `rmsgen -c config.yml`
    Then the exit status should be 0
