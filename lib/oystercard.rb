class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'exceeds top up limit' if amount > 90
    @balance += amount
  end


end