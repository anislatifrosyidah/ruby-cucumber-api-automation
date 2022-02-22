Feature: Search Cat Breeds by name

@search_cat_by_name
Scenario Outline: Client want to search cat breed by name
  Given client search cat breed name by inputing keyword "<keyword_name>"
  Then response should containing "<keyword_name>"
  Then client will see results

  Examples:
      | keyword_name                         |
      | American Curl                        |
      | Aegean                               |
      | American Wirehair                    |
      | Arabian Mau                          |

