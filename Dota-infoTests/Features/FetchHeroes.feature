Feature: Fetch Heroes

 Scenario Outline: As a user, i want to get the full list of heroes

    Given the user ask for a list of heroes
    When API responds with "<api_response>"
    Then result should be "<result>"

    Examples:
      | api_response | result         |
      | error        | error_message  |
      | no_content   | empty_list     |
      | success      | list_of_heroes |

