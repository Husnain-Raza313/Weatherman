# frozen_string_literal: true

require 'Date'

# file = File.open("Dubai_weather/Dubai_weather_2004_Aug.txt")
# file_data=file.read
# puts file_data
max_temp_array = []
min_temp_array = []
date_array = []
humid_array = []

month = Date::MONTHNAMES[ARGV[1].split('/')[1].to_i]
month = month.slice(0...3)
# p month

if ARGV[0] == '-a'
  File.foreach(".#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1].split('/')[0]}_#{month}.txt") do |line| # puts "line#1 : #{line}"
    if line.include?(',')
      s = line.split(',', 10)
      #     #Eliminates Nil Values for High Temperature
      #
      #    if (s[1]!="")
      #     max_temp_array<< s[1]
      #     date_array << s[0]
      #    end
      max_temp_array << s[1]
      min_temp_array << s[3]
      date_array << s[0]
      humid_array << s[8]
    end
  end
end
# def extreme_temp_values(temp_array, date_array, humid_array)
#   # puts max_temp_array.size
#   n = temp_array.size - 2
#   count = 1
#   temp_array = temp_array.reject { |e| e == '' } # Removing nil and "" values
#   temp_array = temp_array.compact
#
#   max_temp = temp_array[count]
#   min_temp = temp_array[count]
#   date_temp = date_array[count]
#
#   n.times do
#     count += 1
#     # puts count
#
#     next if temp_array[count].nil?
#
#     #  # It gives the highest temperature
#     #         if(temp_array[count]>temp && count<temp_array.size)
#     #           temp=temp_array[count]
#     #           date_temp=date_array[count]
#     #         end
#     max_temp = temp_array[count] if temp_array[count] > max_temp
#     min_temp = temp_array[count] if temp_array[count] < min_temp
#   end
#
#   # puts "Highest Temp i.e. #{temp} at Date: #{date_temp} "
#   avg_temp_array = avg_min_max_temp(temp_array, max_temp, min_temp)
#   avg_humid = avg_humid_fn(humid_array)
#
#   p "Highest Average is : #{avg_temp_array[0]}C "
#   p "Lowest Average is : #{avg_temp_array[1]}C "
#   p "Average Humidity is : #{avg_humid}% "
# end
def avg_min_max_temp(max_temp_array, min_temp_array, humid_array)
  # max_temp_array.shift
  # min_temp_array.shift

  # put each of them in methods
  # max_temp_array = max_temp_array.reject { |e| e == '' }.compact.map(&:to_f) # Removing nil and "" values
  # max_temp_array = array_transfrom(max_temp_array)
  # max_temp_array = max_temp_array.compact # Removing nil values
  # max_temp_array = max_temp_array.map(&:to_f) # To Convert Strings into Float Values

  # min_temp_array = min_temp_array.reject { |e| e == '' }.compact.map(&:to_f) # Removing nil and "" values
  # min_temp_array = array_transfrom(min_temp_array)
  # min_temp_array = min_temp_array.compact # Removing nil values
  # min_temp_array = min_temp_array.map(&:to_f) # To Convert Strings into Float Values

  # avg_max = (max_temp_array.sum.to_f / max_temp_array.size).round(2)
  # avg_min = (min_temp_array.sum.to_f / min_temp_array.size).round(2)

  avg_array = []

  avg_array << avg_round(array_transfrom(max_temp_array).sum, max_temp_array.size)
  # avg_array << avg_max
  # avg_array << avg_min
  avg_array << avg_round(array_transfrom(min_temp_array).sum, min_temp_array.size)

  # avg_humid = avg_humid_fn(humid_array)

  print_values(avg_array, avg_humid_fn(humid_array))
end

def array_transfrom(array)
  array.shift
  array.reject { |e| e == '' }.compact.map(&:to_f)
end

def print_values(avg_array, avg_humid)
  p "Highest Average is : #{avg_array[0]}C "
  p "Lowest Average is : #{avg_array[1]}C "
  p "Average Humidity is : #{avg_humid}% "
end

def avg_round(val, total)
  (val.to_f / total).round(2)
end

def avg_humid_fn(humid_array)
  humid_array = humid_array.reject { |e| e == '' }
  humid_array = humid_array.map(&:to_f)
  avg_humid = humid_array.sum.to_f / humid_array.size
  avg_humid.round(1)
end

# extreme_temp_values(temp_array, date_array, humid_array)
avg_min_max_temp(max_temp_array, min_temp_array, humid_array)
# puts max_temp_array
# puts date_array
