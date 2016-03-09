# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

feedback = []
counter = 0

CSV.foreach(Rails.root.join("db/seeds_data/movies.csv"), headers: true, skip_blanks: true, encoding: 'UTF-8') do |row|
  m = Movie.find_or_create_by(title: row[0], release_year: row[1], price: row[2], description: row[3], imdb_id: row[4], poster_url: row[5], video_url: row[6])
  # m = Movie.find_or_initialize_by(title: row[0], release_year: row[1], price: row[2], description: row[3], imdb_id: row[4], poster_url: row[5], video_url: row[6])
  # byebug
  # puts m.video_url
  # m.save

  feedback << { row: counter, persisted: m.persisted?, errors: m.errors.messages, valid: m.valid?, new: m.new_record? }
  counter += 1
end

puts feedback.to_yaml