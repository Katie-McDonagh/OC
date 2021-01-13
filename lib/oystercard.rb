class Oystercard

  MAXBALANCE = 90
  MINBALANCE = 1

  attr_reader :balance, :entry_station
 

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
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

  def touch_in(station)
    @entry_station = station
    raise "must top up card with minimum balance of #{MINBALANCE} first" if balance <  MINBALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINBALANCE)
    @in_journey = false
  end

  private
  def deduct(amount)
    @balance -= amount
  end
  

end