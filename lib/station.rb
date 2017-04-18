require 'csv'

class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

end


# def load_students(filename = "stations.csv")
#   stations = []
#   CSV.foreach(filename) do |line|
#   name, zone = line
#   stations << Station.new(name.to_sym, zone.to_i)
#   end
#   station_hash = {}
#   stations.each { |elt| station_hash[elt.name] = elt }
#   station_hash
# end
