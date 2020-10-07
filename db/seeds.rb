# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'
require 'JSON'
require 'byebug'

# Animal.all.destroy
# User.all.destroy

IUCN_KEY = ENV['iucn_api_key']

counter = 12
animal_array = []
while counter < 13 do
    animal_url = "https://apiv3.iucnredlist.org/api/v3/species/page/0?token=#{IUCN_KEY}"
    url_response = RestClient.get(animal_url)
    json_response = JSON.parse(url_response)
    animal_array.concat(json_response['result'])
    counter += 1
end

animal_array = animal_array.select {|animal| (animal["scientific_name"] && animal['kingdom_name'] == 'ANIMALIA' && animal['phylum_name'] == 'CHORDATA' && (animal["category"] == "CR" || animal["category"] == "VU" || animal["category"] == "EN" || animal["category"] == "EW"))}
animal_array = animal_array.map {|animal| animal['scientific_name']}.shuffle[0...15]

counter = 1
animal_array = animal_array.map do |scientific_name|
    sci_name = scientific_name.downcase.split(" ").join("%20")
    name_url = "https://apiv3.iucnredlist.org/api/v3/species/common_names/#{sci_name}?token=#{IUCN_KEY}"
    url_response = RestClient.get(name_url){ |response, request, result, &block|
        case response.code
        when 200
            puts "It worked #{counter}!"
            response
        when 502
            puts "It didn't work with #{sci_name} #{counter}"
        else
            response.return!(request, result, &block)
        end
  }
    if url_response
        json_response = JSON.parse(url_response)
        result = json_response['result']
        if result && result.length > 0
            if result[0]['language'] == 'eng' && result[0]['taxonname']
                animal_object = {scientific_name: scientific_name, common_name: result[0]['taxonname']}
                counter += 1
                animal_object
            end
        end
    end
end

animal_array.each do |animal|
    if animal
        Animal.create(scientific_name: animal[:scientific_name], common_name: animal[:common_name])
    end
end

# names = ['ian', 'brian', 'james', 'jenn', 'kevin', 'victor', 'vincent', 'mimi']
# names.map{|name| User.create(username: name, password: '1234', password_confirmation: '1234')}

# byebug
"something"
