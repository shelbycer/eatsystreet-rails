Recipe = Struct.new(:name, :rating, :ingredients, :total_time, :directions, :id) do
  class << self

    def search_recipes(user_preference)
      cuisine_search_values = user_preference.cuisine_preference.collect { |preference|
        YUMMLY_SEARCH_VALUES.detect { |search_value|
          search_value['name'] == preference
        }['searchValue'] rescue nil
      }.compact

      search_params = {
        'allowedCuisine' => cuisine_search_values,
        'maxTotalTimeInSeconds' => 3600
      }

      response = RestClient.get search_endpoint_url(search_params)
      response = JSON.parse(response)

      random_recipes = response["matches"].shuffle[0..2]
      random_recipes.map do |i|
        Recipe.new(i["recipeName"], i["rating"], i["ingredients"], i["totalTimeInSeconds"], i["source"], i["id"])
      end


    end

    def find_recipe(recipe_id)
      response = RestClient.get find_endpoint_url(recipe_id)
      response = JSON.parse(response)

      Recipe.new(response['name'],
        response['rating'],
        response['ingredientLines'].join("\n"),
        response['totalTimeInSeconds'],
        response["source"]['sourceRecipeUrl'],
        response['id']
        )
    end

    private

    def search_endpoint_url(search_params)
      uri = URI.parse("https://api.yummly.com")
      uri.path = "/v1/api/recipes"
      uri.query = search_params.update({
        _app_key: ENV["YUMMLY_APP_KEY"],
        _app_id: ENV["YUMMLY_APP_ID"]
      }).to_query

      uri.to_s
    end

    def find_endpoint_url(recipe_id)
      uri = URI.parse("https://api.yummly.com")
      uri.path = "/v1/api/recipe/#{recipe_id}"
      uri.query = {
        _app_key: ENV["YUMMLY_APP_KEY"],
        _app_id: ENV["YUMMLY_APP_ID"],
      }.to_query

      uri.to_s
    end
  end

  def summary
    "Dinner plan: #{name}"
  end

  def description
    "#{ingredients}\n\nDirections: #{directions}"
  end


  YUMMLY_SEARCH_VALUES = JSON.parse(<<-EOT
  [
    {
      "id": "cuisine-american",
      "name": "American",
      "type": "cuisine",
      "description": "American",
      "searchValue": "cuisine^cuisine-american",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-kid-friendly",
      "name": "Kid-Friendly",
      "type": "cuisine",
      "description": "Kid-Friendly",
      "searchValue": "cuisine^cuisine-kid-friendly",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-italian",
      "name": "Italian",
      "type": "cuisine",
      "description": "Italian",
      "searchValue": "cuisine^cuisine-italian",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-asian",
      "name": "Asian",
      "type": "cuisine",
      "description": "Asian",
      "searchValue": "cuisine^cuisine-asian",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-mexican",
      "name": "Mexican",
      "type": "cuisine",
      "description": "Mexican",
      "searchValue": "cuisine^cuisine-mexican",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-southern",
      "name": "Southern & Soul Food",
      "type": "cuisine",
      "description": "Southern & Soul Food",
      "searchValue": "cuisine^cuisine-southern",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-french",
      "name": "French",
      "type": "cuisine",
      "description": "French",
      "searchValue": "cuisine^cuisine-french",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-southwestern",
      "name": "Southwestern",
      "type": "cuisine",
      "description": "Southwestern",
      "searchValue": "cuisine^cuisine-southwestern",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-barbecue-bbq",
      "name": "Barbecue",
      "type": "cuisine",
      "description": "Barbecue",
      "searchValue": "cuisine^cuisine-barbecue-bbq",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-indian",
      "name": "Indian",
      "type": "cuisine",
      "description": "Indian",
      "searchValue": "cuisine^cuisine-indian",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-chinese",
      "name": "Chinese",
      "type": "cuisine",
      "description": "Chinese",
      "searchValue": "cuisine^cuisine-chinese",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-cajun",
      "name": "Cajun & Creole",
      "type": "cuisine",
      "description": "Cajun & Creole",
      "searchValue": "cuisine^cuisine-cajun",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-mediterranean",
      "name": "Mediterranean",
      "type": "cuisine",
      "description": "Mediterranean",
      "searchValue": "cuisine^cuisine-mediterranean",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-greek",
      "name": "Greek",
      "type": "cuisine",
      "description": "Greek",
      "searchValue": "cuisine^cuisine-greek",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-english",
      "name": "English",
      "type": "cuisine",
      "description": "English",
      "searchValue": "cuisine^cuisine-english",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-spanish",
      "name": "Spanish",
      "type": "cuisine",
      "description": "Spanish",
      "searchValue": "cuisine^cuisine-spanish",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-thai",
      "name": "Thai",
      "type": "cuisine",
      "description": "Thai",
      "searchValue": "cuisine^cuisine-thai",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-german",
      "name": "German",
      "type": "cuisine",
      "description": "German",
      "searchValue": "cuisine^cuisine-german",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-moroccan",
      "name": "Moroccan",
      "type": "cuisine",
      "description": "Moroccan",
      "searchValue": "cuisine^cuisine-moroccan",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-irish",
      "name": "Irish",
      "type": "cuisine",
      "description": "Irish",
      "searchValue": "cuisine^cuisine-irish",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-japanese",
      "name": "Japanese",
      "type": "cuisine",
      "description": "Japanese",
      "searchValue": "cuisine^cuisine-japanese",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-cuban",
      "name": "Cuban",
      "type": "cuisine",
      "description": "Cuban",
      "searchValue": "cuisine^cuisine-cuban",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-hawaiian",
      "name": "Hawaiian",
      "type": "cuisine",
      "description": "Hawaiian",
      "searchValue": "cuisine^cuisine-hawaiian",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-swedish",
      "name": "Swedish",
      "type": "cuisine",
      "description": "Swedish",
      "searchValue": "cuisine^cuisine-swedish",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-hungarian",
      "name": "Hungarian",
      "type": "cuisine",
      "description": "Hungarian",
      "searchValue": "cuisine^cuisine-hungarian",
      "localesAvailableIn": [
        "en-US"
      ]
    },
    {
      "id": "cuisine-portuguese",
      "name": "Portuguese",
      "type": "cuisine",
      "description": "Portuguese",
      "searchValue": "cuisine^cuisine-portuguese",
      "localesAvailableIn": [
        "en-US"
      ]
    }
  ]
  EOT
  )
end
