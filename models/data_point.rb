class DataPoint

  attr_reader :date, :level

  def initialize(args={})
    @date = args[:date] || nil
    @level = args[:level] || nil
  end
end
