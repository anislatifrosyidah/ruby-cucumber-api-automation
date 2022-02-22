Feature: Search Cat Breeds Image by id

@search_cat_breed_image_by_id
Scenario: Client want to search breeds image by breeds id from the breed lists
  Given client want to retrieve list Cat Breeds
  Then client will see all cat breed lists
  And client collects first breeds id from breeds lists
  When client search cat breed image by inputing founded cat breeds id
  Then client will see image url of the selected breeds id

@search_cat_breed_image_by_limit_page_order
Scenario Outline: Client want to search breeds image by limit ppage order
  Given client set limit to "<limit>" page to "<page>" and order by "<order>"
  Then client will see all cat breed image list

  Examples:
      | limit              | page   | order |
      | 2                  | 100    | DESC  |
      | 0                  | 2      | DESC  |
      |                    | 10     | ASC   |
      | 100                |        | ASC   |

