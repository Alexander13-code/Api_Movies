# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# Character.create(name: "Luke", movie: movies.first)
Movie.destroy_all

require 'uri'
require 'net/http'
require "open-uri"
require 'json'

url = URI("https://moviesdatabase.p.rapidapi.com/titles")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = ENV["rapidapi-key"]
request["x-rapidapi-host"] = 'moviesdatabase.p.rapidapi.com'

response = http.request(request)
# puts response.read_body

data = JSON.parse(response.read_body)
# puts data

# results = data["results"][0]["titleText"]["text"]
# puts results
results = data["results"]

results.each do |result|
  Movie.create!(
    title_id: result["id"],
    title: result.dig("titleText", "text"),
    original_title: result.dig("originalTitleText", "text"),
    release_year: result.dig("releaseYear", "year"),
    # image_url: result.dig("primaryImage", "url"),
    # image_caption: result.dig("primaryImage", "caption", "plainText")
  )
end

# 
# url_random = "https://moviesdatabase.p.rapidapi.com/titles/random"
# titles_random = URI.parse(url_random).read
# title = JSON.parse(titles_random)
# 
# puts title
