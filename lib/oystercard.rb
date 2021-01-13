class Oystercard

  MAXBALANCE = 90
  MINBALANCE = 1

  attr_reader :balance, :entry_station
 

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise "exceeds top up limit of #{MAXBALANCE}" if amount + balance >  MAXBALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    @entry_station = station
    raise "must top up card with minimum balance of #{MINBALANCE} first" if balance <  MINBALANCE
  end

  def touch_out(station)
    deduct(MINBALANCE)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
  

end