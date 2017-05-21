require 'ascii_charts'

class Reservoir

  attr_reader :name, :data

  def initialize(name, data)
    @name = name
    @data = data
  end

  def add_data(datas)
    @data << datas
  end

  def vizualize_one_point_in_time
  info = data.map {|datapoint| [datapoint.reservoir, datapoint.level] }
  puts AsciiCharts::Cartesian.new(info, :bar => true, :title => "NYC Reservoir System Levels").draw
  end



  def one_day_data

  end

end

class DataPoint

  attr_reader :reservoir, :date, :level

  def initialize(reservoir, date, level)
    @reservoir = reservoir
    @date = date
    @level = level
  end

end

one = DataPoint.new("Never Sink", "1/1/15", 70.05)
two = DataPoint.new("Schoharie","1/1/15", 50.86)
three = DataPoint.new("Pepacton","1/1/15", 92.90)
four = DataPoint.new("Connonsville","1/1/15", 65.93)
five = DataPoint.new("Croton","1/1/15", 88.34)

data = [one, two, three, four, five]

never_sink = Reservoir.new("Never Sink", data)

never_sink.over_time



