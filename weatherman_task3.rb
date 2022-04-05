# frozen_string_literal: true

require 'Date'
require 'colorize'

def print_temp(temp, element, ctr, color)
  print " #{element.split('-')[2]} : "
  if temp[ctr] == 'N/A'
    print " N/A \n"
  else
    if color == 'red'
      temp[ctr].times { print '-'.red }
    else
      temp[ctr].times { print '+'.blue }
    end
    print "#{temp[ctr]}C \n\n"
  end
end

def bonus_task(element, maxminhash, ctr)
  # BONUS TASKKKK!
  # p '(Bonus Task)'
  print " #{element.split('-')[2]} : "
  if maxminhash[:min][ctr] == 'N/A' || maxminhash[:max][ctr] == 'N/A'
    print " N/A \n\n"
  else
    print_red_blue(element, maxminhash, ctr)
    print "#{maxminhash[:max][ctr]}C - #{maxminhash[:min][ctr]}C \n\n" # prints max and min temperature
  end
end

def print_red_blue(_element, maxminhash, ctr)
  maxminhash[:max][ctr].times { print '+'.blue }
  maxminhash[:min][ctr].times { print '-'.red }
end

def print_method(maxminhash, date_array, ctr = 0)
  # printing Month name and Year e.g. March 2015
  p "#{Date::MONTHNAMES[date_array[ctr].split('-')[1].to_i]} #{date_array[ctr].split('-')[0]}"

  date_array.each do |element|
    print_temp(maxminhash[:max], element, ctr, 'blue')

    print_temp(maxminhash[:min], element, ctr, 'red')

    bonus_task(element, maxminhash, ctr)

    ctr += 1 # incrementing
  end
end

def visualize_temp(max_temp_array, min_temp_array, date_array)
  # Shifting first entries which include the labels
  max_temp_array.shift
  min_temp_array.shift
  date_array.shift

  # checking nil values and converting strings into integers
  max_temp_array = check_nil_values(max_temp_array)
  min_temp_array = check_nil_values(min_temp_array)

  maxminhash = {}
  maxminhash[:max] = max_temp_array
  maxminhash[:min] = min_temp_array
  print_method(maxminhash, date_array)
end

def check_nil_values(array)
  array.map do |element|
    # Converting empty string into N/A
    if element == ''
      'N/A'

    else
      element.to_i # Converting non-empty strings into integers
    end
  end
end

# Program Starts Here

max_temp_array = []
min_temp_array = []
date_array = []

month = Date::MONTHNAMES[ARGV[1].split('/')[1].to_i]
month = month.slice(0...3)

if ARGV[0] == '-c'
  File.foreach(".#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1].split('/')[0]}_#{month}.txt") do |line| # puts "line#1 : #{line}"
    # puts line.size
    if line.include?(',') # helps in skipping and storing nil lines
      s = line.split(',', 10)

      max_temp_array << s[1] # maintaing array of high temperature values
      min_temp_array << s[3] # maintaining array of low temperature values
      date_array << s[0] # maintaining array of date
    end
  end
else
  p 'Wrong Command Given'
end

# Calling Function

visualize_temp(max_temp_array, min_temp_array, date_array)
