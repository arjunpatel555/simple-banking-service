class Account
  def initialize(account_number, balance)
    validate_account_number(account_number)
    validate_balance(balance)
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
    validate_balance(balance)
    @balance = balance
  end

  def deposit(amount)
    validate_deposit_amount(amount)
    @balance + amount
  end

  def withdraw(amount)
    validate_withdraw_amount(amount)
    @balance - amount
  end

  private

  def validate_account_number(account_number)
    raise "Account Number must be a string" unless (account_number.is_a? String)
    raise "Account Number must be an string of digits" unless (account_number.scan(/\D/).empty?)
    raise "Account Number must be 16 digits" unless account_number.length == 16
  end

  def validate_balance(balance)
    raise "Balance must be a numeric" unless (balance.is_a? Numeric)
  end

  def validate_deposit_amount(amount)
    raise "Deposit amount must be a numeric" unless (amount.is_a? Numeric)
    raise "Deposit amount must be greater than zero" unless (amount >= 0)
  end

  def validate_withdraw_amount(amount)
    raise "Withdraw amount must be a numeric" unless (amount.is_a? Numeric)
    raise "Withdraw amount must be greater than zero" unless (amount >= 0)
  end

end