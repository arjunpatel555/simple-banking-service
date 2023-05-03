require './lib/contexts/account'

module Transactions
  def load_company_balances(company, csv_file)
    balance_data = CSV_Reader.parse_from_file(csv_file)
    accounts = create_accounts_with_balance(balance_data)

    company.accounts = accounts
  end

  def create_accounts_with_balance(csv_data) 
    csv_data.map{ |row| Account.new(row[0], row[1].to_f)}
  end
end