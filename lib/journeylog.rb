require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize
    @journeys = []
    @journey_class = Journey
  end

  def start(station)
    @current_journey = Journey.new(station)
  end

  def finish(station)
    @current_journey.finish(station)
    @current_journey.fare
  end

  def journeys
    @journeys.dup
  end

  def record_journey
    @journeys << { entry_station: @current_journey.entry_station, exit_station: @current_journey.exit_station }
    @current_journey = nil
  end

private

  def current_journe
    @current_journey ||= @journey_class.new
  end

end
