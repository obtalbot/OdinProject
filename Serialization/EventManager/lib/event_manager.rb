require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
  phone_number = phone_number.gsub(/\D/,'')
  if phone_number.length == 10
    return phone_number
  elsif phone_number.length == 11
    return phone_number.slice(1..10) if phone_number[0] == "1"
  end
  return ""
end

def tally_hours(reg_time, hours)
  reg_time = DateTime.strptime(reg_time,"%m/%d/%Y %H:%M")
  hours[reg_time.hour] += 1
end

def tally_days(reg_time, days)
  reg_time = DateTime.strptime(reg_time,"%m/%d/%Y %H:%M")
  weekdays = {0=>"Sunday", 1=>"Monday", 2=>"Tuesday", 3=>"Wednesday", 4=>"Thursday", 5=>"Friday", 6=>"Saturday"}
  days[weekdays[reg_time.wday]] += 1
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open '../full_event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "../form_letter.erb"
erb_template = ERB.new template_letter

hours = Hash.new(0)
days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  #legislators = legislators_by_zipcode(zipcode)

  #form_letter = erb_template.result(binding)

  #save_thank_you_letters(id,form_letter)

  #puts clean_phone_number(row[:homephone])
  tally_hours(row[:regdate], hours)
  tally_days(row[:regdate], days)
end

  puts hours.sort_by { |k,v| v }.reverse.inspect
  puts days.sort_by { |k,v| v }.reverse.inspect