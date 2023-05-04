require './lib/contexts/account'
require './lib/helpers/csv_reader'

include CSV_Reader

module Transactions
  def load_company_balances(company, csv_file)
    balance_data = CSV_Reader.parse_from_file(csv_file)
    accounts = create_accounts_with_balance(balance_data)

    company.accounts = accounts
  end

  def create_accounts_with_balance(csv_data) 
    csv_data.map{ |row| Account.new(row[0], row[1].to_f)}
  end

  def process_company_transactions(company, csv_file)
    transaction_data = CSV_Reader.parse_from_file(csv_file)

    transaction_data.map{ |row| 
      from_account_number = row[0]
      to_account_number = row[1]
      amount = row[2].to_f
      accounts = get_accounts_for_transaction(company, from_account_number, to_account_number)
      execute_account_transaction(accounts[:from_account], accounts[:to_account], amount)
    }

    company
  end

  def execute_account_transaction(from_account, to_account, amount)
    from_account.withdraw(amount)
    to_account.deposit(amount)
  end

  private

  def get_accounts_for_transaction(company, from_account_number, to_account_number)
  { 
    from_account: company.get_account_by_lookup(from_account_number),
    to_account: company.get_account_by_lookup(to_account_number),
  }
  end
end