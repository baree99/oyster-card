class Journey
attr_accessor :entry_station, :exit_station
MINIMUM_FARE = 1
PENALTY = 6

def initialize
  @entry_station = nil
  @exit_station = nil
end

def fare
  return PENALTY if @entry_station == nil || @exit_station == nil
  MINIMUM_FARE
end


end
