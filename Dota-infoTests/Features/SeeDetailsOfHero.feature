Feature: See Details of a Hero

 Scenario: As a user, i want to see the details of a single hero

    Given the user has loaded a list of heroes
    When he selects the hero "Slark"
    Then should load the name, id and image url of the hero


