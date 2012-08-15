Feature: Interacting with the application
  In order to interact with the running application
  As a Cucumber scenario
  I want to declare my application-based expectations

  Scenario: 
    Given the app has the name "UICukesTestsApp"
    And the device is in "portrait" orientation
    And the device is not in portrait upside down orientation
    When I tap the 1st text field
    And delay 3 seconds
    And tap the 2nd text field
    And type "hello"
    And push the "Push Me" button
    And delay 1 second

