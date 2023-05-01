class Company
  def initialize(name, accounts = [])
    @name = name
    @accounts = accounts
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
end