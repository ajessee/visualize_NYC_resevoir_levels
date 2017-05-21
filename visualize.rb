require 'open-uri'
require 'json'
require 'ascii_charts'
require 'colorize'
require 'colorized_string'
require_relative 'models/data_point'
require_relative 'models/resevoir'
require_relative 'models/parser'
require 'pry'

$resevoirs = $resevoirs || Parser.import

def clear
  system("clear")
end

def control_flow
  hello_user
  selection = user_input
  if (1..5).to_a.include?(selection)
     choice = selection - 1
     vizualize(choice, $resevoirs)
     puts "That was fun! You want to see data on another resevoir? (y/n)".colorize(:yellow)
     handle_answer
   else
     puts "Sorry, didn't catch that. Try again? (y/n)".colorize(:yellow)
     handle_answer
   end 
end

def hello_user
  clear
  puts "This is a simple visulalization program that will show you water levels of NYC resevoirs over the time span of the data set"
  puts
  puts "Please select a resevoir that you would like to see data on:".colorize(:yellow)
  puts "1. Schoharie Resevoir".colorize(:light_blue)
  puts "2. Rondout Resevoir".colorize(:light_blue)
  puts "3. Pepacton Resevoir".colorize(:light_blue)
  puts "4. Cannonsville Resevoir".colorize(:light_blue)
  puts "5. Neversink Resevoir".colorize(:light_blue)
  puts
  puts "Please enter a number and hit enter".colorize(:green)
end

def user_input
  gets.chomp.to_i
end

def vizualize(choice, resevoirs)
  delta = "\u0394"
  resevoirs[choice].data.each_with_index do |obj, i|
    puts "#{resevoirs[choice].name} Resevoir".colorize(:yellow)
    puts "#{resevoirs[choice].data[i].date}".colorize(:yellow)
    puts AsciiCharts::Cartesian.new([["#{delta.encode('utf-8')}", resevoirs[choice].data[i].range], ["Water level (feet)", resevoirs[choice].data[i].level.to_f] ], :bar => true, :hide_zero => true, :title => "Elevation of minimum operating level = #{resevoirs[choice].data[i].min} feet\nElevation of crest of spillway = #{resevoirs[choice].data[i].max} feet\n#{delta.encode('utf-8')} = #{resevoirs[choice].data[i].range} feet".colorize(:green)).draw
    sleep(0.01)
    if i != resevoirs[choice].data.length - 1
      system("clear")
    end
  end
end

def handle_answer
  again = gets.chomp
  if again == "y"
    control_flow
  elsif again == "n"
    system("clear")
    puts "Thanks for checking my project!".colorize(:yellow)
  else
    puts "Sorry, didn't catch that. Try again? (y/n)".colorize(:yellow)
    handle_answer
  end
end


control_flow


