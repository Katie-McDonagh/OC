class Oystercard

  MAXBALANCE = 90

  attr_reader :balance, :in_journey
 

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "exceeds top up limit of #{MAXBALANCE}" if amount + balance >  MAXBALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

end