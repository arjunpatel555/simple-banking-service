class Company
  def initialize(name)
    validate_name(name)
    @name = name
    @accounts = []
  end

  def name
    @name
  end

  def accounts
    @accounts
  end

  def accounts=(accounts)
    @accounts = accounts
  end

  def add_account(account_number, balance)
    new_account = Account.new(account_number, balance)
    @accounts << new_account
    new_account
  end

  def get_account_by_lookup(account_number)
    self.accounts.find{ |account| account.account_number == account_number}
  end

  def validate_name(name)
    raise "Name must be a string" unless (name.is_a? String)
  end
end 