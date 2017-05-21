class Resevoir

  attr_reader :name, :data, :capacity

  def initialize(args={})
    @name = args[:name] || nil
    @data = args[:data] || nil
    @capacity = args[:capacity]
  end


end
