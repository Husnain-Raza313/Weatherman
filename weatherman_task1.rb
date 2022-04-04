# frozen_string_literal: true

require 'Date'

def check_nil_max_values(array)
  array.map do |element|
    if element == ''
      -500_000

    else
      element.to_f
    end
  end
end

def check_nil_min_values(array)
  array.map do |element|
    if element == ''
      10_000

    else

      element.to_f
    end
  end
end

def max_values(max_temp_array1, min_temp_array1, humid_array1, date_array1)
  count = 1
  date_temp = {}

  max_temp_array1 = check_nil_max_values(max_temp_array1)
  min_temp_array1 = check_nil_min_values(min_temp_array1)
  humid_array1 = check_nil_max_values(humid_array1)

  max_temp_array1.shift
  min_temp_array1.shift
  humid_array1.shift

  date_temp[:maxtemp] = date_array1[count]
  date_temp[:mintemp] = date_array1[count]
  date_temp[:maxhumid] = date_array1[count]

  loop_for_arrays(max_temp_array1, min_temp_array1, humid_array1, date_temp, date_array1)
end

def loop_for_arrays(max_temp_array1, min_temp_array1, humid_array1, date_temp, date_array1)
  # Adding one because of shifting of index
  max_temp = max_temp_array1.max
  date_temp[:maxtemp] = date_array1[max_temp_array1.index(max_temp) + 1]

  min_temp = min_temp_array1.min
  date_temp[:mintemp] = date_array1[min_temp_array1.index(min_temp) + 1]

  max_humid = humid_array1.max
  date_temp[:maxhumid] = date_array1[humid_array1.index(max_humid) + 1]

  [max_temp, min_temp, max_humid, date_temp]
end

def check_max(array1, max_temp_value, max_humid_value, max_date)
  if array1[0] > max_temp_value
    max_temp_value = array1[0]
    max_date[:maxtemp] = array1[3][:maxtemp]

  end
  if array1[2] > max_humid_value
    max_humid_value = array1[2]
    max_date[:maxhumid] = array1[3][:maxhumid]
  end
  [max_temp_value, max_humid_value, max_date]
end

def check_max_min(array1, max_temp_value, min_temp_value, max_humid_value, max_date)
  # checking for max_values
  array = check_max(array1, max_temp_value, max_humid_value, max_date)
  max_temp_value = array[0]
  max_humid_value = array[1]
  max_date = array[2]

  # checking for min_values of temperature
  if array1[1] < min_temp_value
    min_temp_value = array1[1]
    max_date[:mintemp] = array1[3][:mintemp]

  end

  [max_temp_value, min_temp_value, max_humid_value, max_date]
end
# frozen_string_literal: true
count = 0
max_temp_array = []
min_temp_array = []
date_array = []
humid_array = []

max_temp_value = 0
min_temp_value = 100_000
max_humid_value = 0
max_date = {}

# files= Dir.glob("**/Dubai_weather/*2015*")
files = Dir.glob("**#{ARGV[2]}/*#{ARGV[1]}*")

if ARGV[0] == '-e' && !files.nil?

  files.each do |file|
    File.foreach(file) do |line|
      if line.include?(',')

        s = line.split(',', 10)
        max_temp_array << s[1]
        min_temp_array << s[3]
        date_array << s[0]
        humid_array << s[7]
        count += 1
      end
    end

    array1 = max_values(max_temp_array, min_temp_array, humid_array, date_array)

    array2 = check_max_min(array1, max_temp_value, min_temp_value, max_humid_value, max_date)

    max_temp_value = array2[0]
    min_temp_value = array2[1]
    max_humid_value = array2[2]
    max_date = array2[3]

    max_temp_array = []
    min_temp_array = []
    date_array = []
    humid_array = []
  end

  maxtemp_month = Date::MONTHNAMES[max_date[:maxtemp].split('-')[1].to_i]
  maxtemp_day = max_date[:maxtemp].split('-')[2].to_i

  mintemp_month = Date::MONTHNAMES[max_date[:mintemp].split('-')[1].to_i]
  mintemp_day = max_date[:mintemp].split('-')[2].to_i

  humid_month = Date::MONTHNAMES[max_date[:maxhumid].split('-')[1].to_i]
  humid_day = max_date[:maxhumid].split('-')[2].to_i

  p "Highest: #{max_temp_value}C on #{maxtemp_month} #{maxtemp_day} "
  p "Lowest: #{min_temp_value}C on #{mintemp_month} #{mintemp_day} "
  p "Humid : #{max_humid_value}% on #{humid_month} #{humid_day} "
else
  p 'No Such File Exists or check your command!'
end
