require 'csv'

## deleting all tables

puts "Deleting all tables ❌"
Timezone.destroy_all
Company.destroy_all
Partnership.destroy_all
Calendar.destroy_all
Meeting.destroy_all
puts "Deleted! 👻"

## seeding timezones from '/lib/seeds/time_zones.csv'

puts "Seeding timezones ⏰"
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
puts "There are now #{Timezone.count} rows in the timezones table 👌"

## seeding companies with faker

puts "Seeding companies 🚧"
10.times do
  tz = Timezone.all.sample
  Company.create(
    name: "#{Faker::Company.name}"+" "+"#{Faker::Company.suffix}",
    description: Faker::Company.industry,
    country_code: tz.code,
    time_zone_offset: tz.offset,
    work_days: '0,1,2,3,4',
    # work_days: (0..6).to_a.sample(5).join(","),
    open_time: "07:00",
    close_time: "19:00"
  )
end
puts "There are now #{Company.count} rows in the companies table 👌"
puts "Done! ✅"

## seeding partnerships
## seeding calendars
## seeding meetings

# response = RestClient::Request.execute(
# method: :get,
# url: 'https://calendarific.com/api/v2/holidays.json',
# headers: {
#   api_key: ENV['API_KEY'],
#   country: 
#   year: 2019
# } 
# )
