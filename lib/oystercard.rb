class Oystercard

  BALANCE_LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance, :origin_station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(credit)
    new_balance = @balance += credit
    raise "Maximum balance is £#{BALANCE_LIMIT}." if new_balance > BALANCE_LIMIT

    @balance = new_balance
  end



  def in_journey?
    @origin_station == nil ? false : true
  end

  def touch_in(origin_station)
    fail "Access denied. Card balance below min." unless @balance >= MIN_BALANCE
    @origin_station = origin_station
  end

  def touch_out
    deduct(1)
    @origin_station = nil
  end


private

  def deduct(debit)
    @balance -= debit
  end


end
