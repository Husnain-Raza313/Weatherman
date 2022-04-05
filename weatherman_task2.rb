require 'Date'

def avg_min_max_temp(max_temp_array, min_temp_array, humid_array)
  avg_array = []
  # Sending sum of array and size of array into avg_round method
  avg_array << avg_round(array_transfrom(max_temp_array).sum, max_temp_array.size)

  avg_array << avg_round(array_transfrom(min_temp_array).sum, min_temp_array.size)
  avg_array << avg_round(array_transfrom(humid_array).sum, humid_array.size)

  print_values(avg_array)
end

def array_transfrom(array)
  # Removing empty strings, nil values and converting strings into float values
  array.shift
  array.reject { |e| e == '' }.compact.map(&:to_f)
end

def print_values(avg_array)
  p "Highest Average is : #{avg_array[0]}C "
  p "Lowest Average is : #{avg_array[1]}C "
  p "Average Humidity is : #{avg_array[2]}% "
end

def avg_round(val, total)
  # Taking average and rounding-off
  (val.to_f / total).round(2)
end

# Program starts here

max_temp_array = []
min_temp_array = []
date_array = []
humid_array = []

month = Date::MONTHNAMES[ARGV[1].split('/')[1].to_i]
month = month.slice(0...3) # Turning number into month name
# p month

if ARGV[0] == '-a'
  File.foreach(".#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1].split('/')[0]}_#{month}.txt") do |line| # puts "line#1 : #{line}"
    if line.include?(',')
      s = line.split(',', 10)
      max_temp_array << s[1]
      min_temp_array << s[3]
      date_array << s[0]
      humid_array << s[8]
    end
  end
end

avg_min_max_temp(max_temp_array, min_temp_array, humid_array)
