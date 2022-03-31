require "Date"

max_temp_array=Array.new
min_temp_array=Array.new
date_array=Array.new

File.foreach("Dubai_weather/Dubai_weather_2004_Aug.txt") do
  |line| #puts "line#1 : #{line}"
  s= line.split(",",10)
=begin
   #Eliminates Nil Values for High Temperature

  if (s[1]!="")

   max_temp_array<< s[1]
   date_array << s[0]
  end
=end

max_temp_array << s[1] #maintaing array of high temperature values
min_temp_array << s[3] #maintaining array of low temperature values
date_array << s[0]  #maintaining array of date

 end

 def visualize_temp(max_temp_array, min_temp_array, date_array)

    day_array=Array.new
    month_array=""
    year_array=""

    #Shifting first entries which include the labels
    max_temp_array.shift
    min_temp_array.shift
    date_array.shift

    #To Convert Strings into Integer Values

    max_temp_array=max_temp_array.map(&:to_i)
    min_temp_array=min_temp_array.map(&:to_i)

    #p max_temp_array
    #p min_temp_array


    #Separating Days, months and years from the Date

    date_array.each do
      |e|
      array=e.split("-")
      day_array << array[2]
      month_array = array[1]
      year_array = array[0]
    end

    #p day_array


    #strings for storing symbols for high and low temperature values
    str_plus=""
    str_minus=""
    count=0


   p "#{Date::MONTHNAMES[month_array.to_i]} #{year_array}"  # changing number into month's name

    # storing symbols in strings
    day_array.each do |element|

        max_temp_array[count].times { str_plus << "+"}
        min_temp_array[count].times { str_minus << "-"}

        p "#{element} : #{str_plus} #{max_temp_array[count]}C"
        p "#{element} : #{str_minus} #{min_temp_array[count]}C"

        count=count+1 #incrementing
        str_plus=""
        str_minus=""
    end
 end

 #Calling Function

 visualize_temp(max_temp_array,min_temp_array,date_array)
