Given("client want to retrieve list Cat Breeds") do
  @get_all_breads = HTTParty.get 'https://api.thecatapi.com/v1/breeds',
  :headers => {
      "Content-Type" => 'application/json',
      "x-api-key" => 'a1cc0f21-4e62-442c-98db-9a48365350b1'
    }
end

Then("client will see all cat breed lists") do
  puts @get_all_breads.body
  puts @get_all_breads.code
  expect(@get_all_breads.code).to eq 200

  @response_raw = @get_all_breads unless @get_all_breads.nil?
  body = @get_all_breads.body
  @response_get = JSON&.parse((@get_all_breads.body).to_s) unless body.nil?
end

Given(/^client search cat breed name by inputing keyword "([^"]*)"$/) do |keyword_name|
  @keyword_name_input = keyword_name
  @search_breeds_name = HTTParty.get "https://api.thecatapi.com/v1/breeds/search?q=#{@keyword_name_input}",
  :headers => {
      "Content-Type" => 'application/json',
      "x-api-key" => 'a1cc0f21-4e62-442c-98db-9a48365350b1'
    }
  @response_raw = @search_breeds_name unless @search_breeds_name.nil?
  body = @search_breeds_name.body
  header = @search_breeds_name.headers
 
  @response = JSON&.parse(@search_breeds_name.body) unless body.nil?

  puts @search_breeds_name
end

Then (/^client will see results$/) do
  @json_response = JSON.parse(@search_breeds_name.body)
puts @json_response
end


Given(/^client search cat breed name by input keyword$/) do
  @search_breeds_name = HTTParty.get 'https://api.thecatapi.com/v1/breeds/search?q=American',
    :headers => {
        "Content-Type" => 'application/json',
        "x-api-key" => 'a1cc0f21-4e62-442c-98db-9a48365350b1'
      }
  puts @json_response
  @response_raw = @search_breeds_name unless @search_breeds_name.nil?
  body = @search_breeds_name.body
  @response = JSON&.parse(@search_breeds_name.body) unless body.nil?
  
end

Then(/^response should containing "([^"]*)"$/) do |value|
  expected_value = value
  actual_value = @response.map{|d| d["name"]}
  expect(actual_value.to_s).to include(expected_value)
end

And(/^client collects first breeds name from breeds lists$/) do
  list_cats = @response_get.map{|d| d["name"]}.to_a
  collected_value = list_cats.first(1)
  @collected_name = (collected_value.to_s).tr('[]""','')
  puts @collected_name
end

And(/^client collects first breeds id from breeds lists$/) do 
  @list_cats_id = @response_get.map{|d| d["id"]}.to_a
  collected_id = @list_cats_id.first(1)
  @collected_first_id = (collected_id.to_s).tr('[]""','')
  puts @collected_first_id
end

When(/^client search cat breed name by inputing founded cat breeds name$/) do
  @search_breeds_name = HTTParty.get "https://api.thecatapi.com/v1/breeds/search?q=#{@collected_name}",
      :headers => {
          "Content-Type" => 'application/json',
          "x-api-key" => 'a1cc0f21-4e62-442c-98db-9a48365350b1'
        }
    @response_raw = @search_breeds_name unless @search_breeds_name.nil?
    body = @search_breeds_name.body
    @response = JSON&.parse(@search_breeds_name.body) unless body.nil?

  puts @search_breeds_name
  expect(@search_breeds_name.code).to eq 200
end

When(/^client search cat breed image by inputing founded cat breeds id$/) do
  @search_breeds_image = HTTParty.get "https://api.thecatapi.com/v1/images/search?breed_id=#{@collected_first_id}",
      :headers => {
          "Content-Type" => 'application/json',
          "x-api-key" => 'a1cc0f21-4e62-442c-98db-9a48365350b1'
        }
    @response_raw = @search_breeds_image unless @search_breeds_image.nil?
    body = @search_breeds_image.body
    @response_image = JSON&.parse(@search_breeds_image.body) unless body.nil?

    url_image = @response_image.map{|d| d["url"]}.to_a
    expect(@search_breeds_image.code).to eq 200
end

Then(/^client will see image url of the selected breeds id$/) do
    url_image = @response_image.map{|d| d["url"]}.to_a
    puts url_image
end



Then(/^client set limit to "([^"]*)" page to "([^"]*)" and order by "([^"]*)"$/) do |limit,page,order|
    @search_by_limit_page_order = HTTParty.get "https://api.thecatapi.com/v1/images/search?limit=#{limit}&page=#{page}&order=#{order}",
      :headers => {
          "Content-Type" => 'application/json',
          "x-api-key" => 'a1cc0f21-4e62-442c-98db-9a48365350b1'
        }
    @response_raw = @search_by_limit_page_order unless @search_by_limit_page_order.nil?
    body = @search_by_limit_page_order.body
    @response_searchlimitpageorder = JSON&.parse(@search_by_limit_page_order.body) unless body.nil?
    
    puts @search_by_limit_page_order.body
    expect(@search_by_limit_page_order.code).to eq 200
end

Then("client will see all cat breed image list") do
  puts @search_by_limit_page_order.body
end
