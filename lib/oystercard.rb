require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :in_journey, :journey_history
  DEFAULT_LIMIT = 90
  MIN_FUNDS = 1
  FARE = 1

  def initialize
    @balance, @journey_history = 0, []
  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    spend(@journey.fare) if in_journey?
    fail 'Insufficient funds' if @balance < MIN_FUNDS
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey = Journey.new if !in_journey?
    @journey.finish(station)
    spend(@journey.fare)
  end

  def in_journey?
    !!@journey
  end

  def save_journey
    @journey_history << { entry_station: @journey.entry_station, exit_station: @journey.exit_station}
    @journey = nil
  end

  private

  def spend(amount)
    @balance -= amount
    save_journey
  end

end
