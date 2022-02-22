Feature: Get All Cat Breeds

@get-all-breeds-lists
Scenario: Client want to see all cat breeds lists
  Given client want to retrieve list Cat Breeds
  Then client will see all cat breed lists

@search_breeds_name_from_list_breeds
Scenario: Client want to search by breeds name from the breeds lists
  Given client want to retrieve list Cat Breeds
  Then client will see all cat breed lists
  And client collects first breeds name from breeds lists
  When client search cat breed name by inputing founded cat breeds name
  Then response should containing "Abyssinian"
