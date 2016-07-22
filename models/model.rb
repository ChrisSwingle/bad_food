require 'uri'
require 'net/http'
require 'json'
require 'pry'


def format_request_and_send_api_call(zipcode)
   rating_request = "https://data.cityofnewyork.us/resource/9w7m-hzhe.json?zipcode=#{zipcode}"
   make_api_call(rating_request)
end

def make_api_call(request_string)
    uri = URI(request_string) #open portal for app
    response = Net::HTTP.get(uri)
    formatted_data = JSON.parse(response) # turn data into something app understands
    # zipcode = formatted_data.first["zipcode"]

    organize_hash(formatted_data)
end

#Removes all resteraunts that are not in the zipcode
def formatting(zipcode, formatted_data)
    formatted_data.keep_if do |elements|
        elements["zipcode"] == zipcode
    end
    organize_hash(formatted_data)
end

#creates a hash with the resteraunts as keys and the value ar arrays with the resteraunts actions address grade
def organize_hash(data)
    hash = {}
    data.each do |restaurant|
        restaurant_name = restaurant["dba"]
        hash[restaurant_name] ||= []
        attributes = {}
        attributes["action"] = restaurant["violation_description"]
        attributes["address"] = "#{restaurant["building"]} #{restaurant["street"]}  #{restaurant["zipcode"]}"
        if restaurant["grade"]
            attributes["grade"] = restaurant["grade"] 
        else
            attributes["grade"] = "Pending"
        end
        hash[restaurant_name] << attributes
    end
    p hash
    hash
end





