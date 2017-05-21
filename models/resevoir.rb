class Resevoir

  attr_reader :name, :data, :level

  def initialize(args={})
    @name = args[:name] || nil
    @data = args[:data] || nil
    @level = args[:level]
  end


end
