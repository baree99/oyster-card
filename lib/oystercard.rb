require_relative 'station'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :journeylog
  DEFAULT_LIMIT = 90
  MIN_FUNDS = 1

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    touch_out(nil) if in_journey?
    fail 'Insufficient funds' if @balance < MIN_FUNDS
    @journeylog.start(station)
  end

  def touch_out(station)
    @journeylog.start(nil) if !in_journey?
    @journeylog.finish(station)
    deduct(@journeylog.current_journey.fare)
    @journeylog.record_journey
  end

  def in_journey?
    !!@journeylog.current_journey
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
