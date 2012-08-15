Feature: Interacting with the application
  In order to interact with the running application
  As a Cucumber scenario
  I want to declare my application-based expectations

  Scenario: 
    Given the app has the name "UICukesTestsApp"
    When the device is in "portrait" orientation
    And the device is not in portrait upside down orientation
    Then tap the 1st text field
    And delay 3 second
    And tap the 2nd text field

