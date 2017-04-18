require_relative 'station'
require_relative 'journey'

class Oystercard
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  attr_reader :balance, :entry_station, :exit_station, :journey

  def initialize
    @balance = DEFAULT_BALANCE
    @trip = Journey.new
    @journey = []
  end

  def top_up(value)
    fail "Maximum balance (£#{MAXIMUM_BALANCE}) reached" if (@balance + value) > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    deduct(@trip.fare) if in_journey?
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @trip = Journey.new
    @trip.start(station)
  end

  def touch_out(station)
    @trip.finish(station)
    deduct(@trip.fare)
    @journey << @trip.last_journey
  end

  def in_journey?
    !!@trip.entry_station
  end

private

  def deduct(value)
    @balance -= value
  end
end
