Feature: Fetch Dota Heroes

 Scenario Outline: Fetch Heroes

    Given the user ask for a list of heroes
    When he fetches data from API
    And API responds with "<api_response>"
    Then result should be "<result>"

    Examples:
      | api_response | result         |
      | error        | error_message  |
      | no_content   | empty_list     |
      | success      | list_of_heroes |

