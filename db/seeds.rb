# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'json'

## deleting all tables

Timezone.destroy_all
Company.destroy_all
Partnership.destroy_all
Calendar.destroy_all
Event.destroy_all

## seeding timezones from '/lib/seeds/time_zones.csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'time_zones.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  t = Timezone.new
  t.code = row['Country Code']
  t.name = row['Country Name']
  t.zone = row['Time Zone']
  t.offset = row['GMT Offset']
  t.save
  puts "#{t.name}, #{t.zone} saved"
end

puts "There are now #{Timezone.count} rows in the timezones table"

## seeding companies with faker

# week = ["mo", "tu", "we", "th", "fr", "sa", "su"]


Company.create(
  name: "#{Faker::Company.name}"+" "+"#{Faker::Company.suffix}",
  description: Faker::Company.industry,
  country_code: 'US',
  time_zone_offset: 'UTC -05:00',
  work_days: '0,1,2,3,4',
  # work_days: (0..6).to_a.sample(5).join(","),
  open_time: "07:00",
  close_time: "19:00"
)

Company.create(
  name: "#{Faker::Company.name}"+" "+"#{Faker::Company.suffix}",
  description: Faker::Company.industry,
  country_code: 'GB',
  time_zone_offset: 'UTC',
  work_days: '0,1,2,3,4',
  # work_days: (0..6).to_a.sample(5).join(","),
  open_time: "07:00",
  close_time: "19:00"
)



# 5.times do
#   Company.create(
#     name: "#{Faker::Company.name}+" "+#{Faker::Company.suffix}",
#     description: Faker::Company.industry,
#     country_code: Timezone.all.sample.code,
#     time_zone_offset: Timezone.all.find_by(code: country_code).offset,
#     work_days: '0,1,2,3,4',
#     # work_days: (0..6).to_a.sample(5).join(","),
#     open_time: "07:00",
#     close_time: "19:00"
#   )
# end

## seeding partnerships

# Partnership.create(company_id: 1, calendar_id: 1)
# Partnership.create(company_id: 2, calendar_id: 1)
# Partnership.create(company_id: 3, calendar_id: 2)
# Partnership.create(company_id: 4, calendar_id: 2)
# Partnership.create(company_id: 5, calendar_id: 2)

## seeding calendars

# Calendar.create(name: "two companies test calendar")
# Calendar.create(name: "three companies test calendar")

## seeding events

# response = RestClient::Request.execute(
# method: :get,
# url: 'https://calendarific.com/api/v2/holidays.json',
# headers: {
#   api_key: ENV['API_KEY'],
#   country: 
#   year: 2019
# } 
# )
