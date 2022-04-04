# frozen_string_literal: true

require 'Date'

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
      max_temp_array << s[1]
      min_temp_array << s[3]
      date_array << s[0]
      humid_array << s[8]
    end
  end
end

def avg_min_max_temp(max_temp_array, min_temp_array, humid_array)
  avg_array = []

  avg_array << avg_round(array_transfrom(max_temp_array).sum, max_temp_array.size)

  avg_array << avg_round(array_transfrom(min_temp_array).sum, min_temp_array.size)

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

avg_min_max_temp(max_temp_array, min_temp_array, humid_array)
