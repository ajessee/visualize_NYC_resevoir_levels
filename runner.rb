require 'open-uri'
require 'json'
require 'ascii_charts'
require_relative 'models/data_point'
require_relative 'models/resevoir'
require_relative 'models/parser'
require 'pry'

# neversink = Parser.import('neversink')
# cannon = Parser.import('cannon')
# neversink = Parser.import('neversink')
# neversink = Parser.import('neversink')
# neversink = Parser.import('neversink')

def vizualize(reservoirs)
  reservoirs[0].data.each_with_index do |obj, i|
    # binding.pry
    puts reservoirs[0].data[i].date
    puts AsciiCharts::Cartesian.new([[reservoirs[0].name, reservoirs[0].data[i].level], [reservoirs[1].name, reservoirs[1].data[i].level], [reservoirs[2].name, reservoirs[2].data[i].level], [reservoirs[3].name, reservoirs[3].data[i].level],[reservoirs[4].name, reservoirs[4].data[i].level],["Maximum + 30%", 130]], :bar => true, :title => "NYC Reservoir System Levels").draw
    sleep(0.01)
    system("clear")
  end
end

reservoir_names = Parser::CAPACITIES.keys

reservoirs = reservoir_names.map do |name|
    Parser.import(name)
  end

vizualize(reservoirs)
