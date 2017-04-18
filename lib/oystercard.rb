require_relative 'station'

class Oystercard
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  attr_reader :balance, :entry_station, :exit_station, :journey

  def initialize
    @balance = DEFAULT_BALANCE
    @journey = []
  end

  def top_up(value)
    fail "Maximum balance (£#{MAXIMUM_BALANCE}) reached" if (@balance + value) > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    @exit_station = nil
    @entry_station = station
    fail "Insufficient funds" if @balance < MINIMUM_FARE
  end

  def touch_out(station)
    @exit_station = station
    @journey << trip
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    !!@entry_station
  end

private

  def trip
    { entry_station: @entry_station, exit_station: @exit_station }
  end

  def deduct(value)
    @balance -= value
  end
end
