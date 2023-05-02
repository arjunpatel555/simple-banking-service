class Account
  def initialize(account_number, balance)
    validate_account_number(account_number)
    vaildate_balance(balance)
    @account_number = account_number
    @balance = balance
  end

  def account_number
    @account_number
  end

  def account_number=(account_number)
    validate_account_number(account_number)
    @account_number = account_number
  end

  def balance
    @balance
  end

  def balance=(balance)
    vaildate_balance(balance)
    @balance = balance
  end

  private

  def validate_account_number(account_number)
    raise "Account Number must be a string" unless (account_number.is_a? String)
    raise "Account Number must be an string of digits" unless (account_number.scan(/\D/).empty?)
    raise "Account Number must be 16 digits" unless account_number.length == 16
  end

  def vaildate_balance(balance)
    raise "Balance must be a number" unless (balance.is_a? Numeric)
  end
end