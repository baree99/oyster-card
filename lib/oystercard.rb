class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(value)
    fail "Maximum balance (£#{MAXIMUM_BALANCE}) reached" if (@balance + value) > MAXIMUM_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end
end
