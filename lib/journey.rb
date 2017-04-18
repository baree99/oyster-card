class Journey
attr_accessor :entry_station, :exit_station, :last_journey
MINIMUM_FARE = 1
PENALTY = 6

def initialize
  @entry_station = nil
  @exit_station = nil
  @last_journey = {}
end

def fare
  return PENALTY if @last_journey[:entry_station] == nil || @last_journey[:exit_station] == nil
  MINIMUM_FARE if @last_journey[:entry_station] != nil && @last_journey[:exit_station] != nil
end

def start(station)
  @exit_station = nil
  @entry_station = station
end

def finish(station)

  @exit_station = station
  trip
  @entry_station = nil
end

def trip
  @last_journey = { entry_station: @entry_station, exit_station: @exit_station }
end


end
