class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance, :in_use

  def initialize(balance = 0)
    @balance = balance
    @in_use = false
  end

  def top_up(value)
    fail "Maximum balance (£#{MAXIMUM_BALANCE}) reached" if (@balance + value) > MAXIMUM_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    !!@in_use
  end
end
