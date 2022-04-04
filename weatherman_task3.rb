# frozen_string_literal: true

require 'Date'
require 'colorize'

max_temp_array = []
min_temp_array = []
date_array = []

month = Date::MONTHNAMES[ARGV[1].split('/')[1].to_i]
month = month.slice(0...3)

if ARGV[0] == '-c'
  File.foreach(".#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1].split('/')[0]}_#{month}.txt") do |line| # puts "line#1 : #{line}"
    # puts line.size
    if line.include?(',')
      s = line.split(',', 10)

      max_temp_array << s[1] # maintaing array of high temperature values
      min_temp_array << s[3] # maintaining array of low temperature values
      date_array << s[0] # maintaining array of date
    end
  end
end
def print_max_temp(maxminhash, element, ctr)
  print " #{element.split('-')[2]} : "
  if maxminhash[:max][ctr] == 'N/A'
    print " N/A \n"
  else
    maxminhash[:max][ctr].times { print '+'.blue }

    print "#{maxminhash[:max][ctr]}C \n"
  end
end

def print_min_temp(maxminhash, element, ctr)
  print " #{element.split('-')[2]} : "
  if maxminhash[:min][ctr] == 'N/A'
    print " N/A \n"
  else
    maxminhash[:min][ctr].times { print '-'.red }

    print "#{maxminhash[:min][ctr]}C \n\n"
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
    print "#{maxminhash[:max][ctr]}C - #{maxminhash[:min][ctr]}C \n\n"
  end
end

def print_red_blue(_element, maxminhash, ctr)
  maxminhash[:max][ctr].times { print '+'.blue }
  maxminhash[:min][ctr].times { print '-'.red }
end

def print_method(maxminhash, date_array, ctr = 0)
  p "#{Date::MONTHNAMES[date_array[ctr].split('-')[1].to_i]} #{date_array[ctr].split('-')[0]}"

  # storing symbols in strings
  date_array.each do |element|
    print_max_temp(maxminhash, element, ctr)

    print_min_temp(maxminhash, element, ctr)

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
    if element == ''
      'N/A'

    else
      element.to_i
    end
  end
end

# Calling Function

visualize_temp(max_temp_array, min_temp_array, date_array)
