class DataPoint

  attr_reader :date, :level, :max, :min, :range

  def initialize(args={})
    @date = args[:date] || nil
    @level = args[:level] || nil
    @max = args[:max] || nil
    @min = args[:min] || nil
    @range = @max - @min
  end
end
