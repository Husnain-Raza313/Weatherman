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
      # p element
      element.to_f
    end
  end
end

def max_values(max_temp_array1, min_temp_array1, humid_array1, date_array1)
  # puts max_temp_array.size
  # n = max_temp_array1.size - 1
  count = 1
  date_temp = {}
  # max_temp_array1.shift
  # min_temp_array1.shift
  # humid_array1.shift

  max_temp_array1 = check_nil_max_values(max_temp_array1)
  min_temp_array1 = check_nil_min_values(min_temp_array1)
  humid_array1 = check_nil_max_values(humid_array1)

  max_temp_array1.shift
  min_temp_array1.shift
  humid_array1.shift
  # max_temp_array1 = max_temp_array1.map(&:to_f)
  # min_temp_array1 = min_temp_array1.map(&:to_f)
  # humid_array1 = humid_array1.map(&:to_f)
  # p max_temp_array1

  # max_temp = max_temp_array1[count].to_f
  # min_temp = min_temp_array1[count].to_f
  date_temp[:maxtemp] = date_array1[count]
  date_temp[:mintemp] = date_array1[count]
  date_temp[:maxhumid] = date_array1[count]
  # p date_temp
  # max_humid = humid_array1[count].to_f

  # n.times do
  #   # puts max_temp
  #   if max_temp_array1[count] > max_temp

  #     max_temp = max_temp_array1[count]
  #     date_temp[:maxtemp] = date_array1[count]
  #   end

  #   if min_temp_array1[count] < min_temp
  #     min_temp = min_temp_array1[count]
  #     date_temp[:mintemp] = date_array1[count]
  #     # p min_temp

  #   end

  #   if humid_array1[count] > max_humid
  #     max_humid = humid_array1[count]
  #     date_temp[:maxhumid] = date_array1[count]
  #   end
  #   count += 1
  # end

  loop_for_arrays(max_temp_array1, min_temp_array1, humid_array1, date_temp, date_array1)
  # p min_temp
  # [max_temp, min_temp, max_humid, date_temp]

  # p "Highest Average is : #{avg_temp_array[0]}C "
  # p "Lowest Average is : #{avg_temp_array[1]}C "
  # p "Average Humidity is : #{avg_humid}% "
end

def loop_for_arrays(max_temp_array1, min_temp_array1, humid_array1, date_temp, date_array1)
  # n = max_temp_array1.size - 1
  # Adding one because of shifting of indexes
  max_temp = max_temp_array1.max
  date_temp[:maxtemp] = date_array1[max_temp_array1.index(max_temp) + 1]

  min_temp = min_temp_array1.min
  date_temp[:mintemp] = date_array1[min_temp_array1.index(min_temp) + 1]
  # p min_temp_array1.index(min_temp)
  # p min_temp_array1
  max_humid = humid_array1.max
  date_temp[:maxhumid] = date_array1[humid_array1.index(max_humid) + 1]

  # puts date_temp

  # (max_temp_array1.size - 1).times do
  # puts max_temp
  # if max_temp_array1[count] > max_temp

  #   max_temp = max_temp_array1[count]
  #   date_temp[:maxtemp] = date_array1[count]
  # end

  #   if min_temp_array1[count] < min_temp
  #     min_temp = min_temp_array1[count]
  #     date_temp[:mintemp] = date_array1[count]
  #     # p min_temp

  #   end

  #   if humid_array1[count] > max_humid
  #     max_humid = humid_array1[count]
  #     date_temp[:maxhumid] = date_array1[count]
  #   end
  #   count += 1
  # end
  [max_temp, min_temp, max_humid, date_temp]
end

def check_max(array1, max_temp_value, max_humid_value, max_date)
  if array1[0] > max_temp_value
    max_temp_value = array1[0]
    max_date[:maxtemp] = array1[3][:maxtemp]
    # p array1[3]

  end
  if array1[2] > max_humid_value
    max_humid_value = array1[2]
    max_date[:maxhumid] = array1[3][:maxhumid]
  end
  [max_temp_value, max_humid_value, max_date]
end

def check_max_min(array1, max_temp_value, min_temp_value, max_humid_value, max_date)
  # if array1[0] > max_temp_value
  #   max_temp_value = array1[0]
  #   max_date[:maxtemp] = array1[3][:maxtemp]

  # end

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

  # if array1[2] > max_humid_value
  #   max_humid_value = array1[2]
  #   max_date[:maxhumid] = array1[3][:maxhumid]
  # end
  [max_temp_value, min_temp_value, max_humid_value, max_date]
end
# frozen_string_literal: true
count = 0
max_temp_array = []
min_temp_array = []
date_array = []
humid_array = []

# max_temp_array1=[]
# min_temp_array1 = []
# date_array1 = []
# humid_array1 = []

max_temp_value = 0
min_temp_value = 100_000
max_humid_value = 0
max_date = {}

# files= Dir.glob("**/Dubai_weather/*2015*")
files = Dir.glob("**#{ARGV[2]}/*#{ARGV[1]}*")

if ARGV[0] == '-e' && files.nil?

  files.each do |file|
    File.foreach(file) do |line| # puts "line#1 : #{line}"
      if line.include?(',')
        # p line

        s = line.split(',', 10)
        max_temp_array << s[1]
        min_temp_array << s[3]
        date_array << s[0]
        humid_array << s[7]
        count += 1
      end
    end
    # p" ends here!!!! \n\n"
    # p min_temp_array
    # p max_temp_array
    # p min_temp_array
    # puts " FILE #{count} ENDED HERE \n \n"
    # max_temp_array1[count]=max_temp_array

    # min_temp_array1[count]=min_temp_array

    # date_array1[count]=date_array

    # humid_array1[count]=humid_array

    # p date_array1[count]
    # p max_temp_array1[count]
    # p min_temp_array1[count]
    # p humid_array1[count]

    # p min_temp_array
    # p date_array
    # p humid_array
    # array1 = []
    array1 = max_values(max_temp_array, min_temp_array, humid_array, date_array)

    array2 = check_max_min(array1, max_temp_value, min_temp_value, max_humid_value, max_date)
    # if array1[0] > max_temp_value
    #   max_temp_value = array1[0]
    #   max_date[:maxtemp] = array1[3][:maxtemp]

    # end

    # if array1[1] < min_temp_value
    #   min_temp_value = array1[1]
    #   max_date[:mintemp] = array1[3][:mintemp]

    # end

    # if array1[2] > max_humid_value
    #   max_humid_value = array1[2]
    #   max_date[:maxhumid] = array1[3][:maxhumid]
    # end
    max_temp_value = array2[0]
    min_temp_value = array2[1]
    max_humid_value = array2[2]
    max_date = array2[3]

    # p max_date

    max_temp_array = []
    min_temp_array = []
    date_array = []
    humid_array = []
  end
  # end

  # if ARGV[0] == '-e' && files.nil?
  # p "#{Date::MONTHNAMES[month_array.to_i]} #{year_array}"
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
  p 'No Such File Exists'
end

# max_values(max_temp_array1,min_temp_array1,humid_array1,date_array1,count)
