class Oystercard

  MAXBALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "exceeds top up limit of #{MAXBALANCE}" if amount + balance >  MAXBALANCE
    @balance += amount
  end


end