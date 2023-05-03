require './lib/transactions'
require './lib/contexts/company'

include Transactions

BALANCES_CSV_DATA = [["1234567812345678", "5000.00"], ["2345678123456789", "50.00"]]
BALANCES_CSV_FILE = "spec/lib/transactions_balance.csv"

describe ".create_accounts_with_balance" do
  it "returns list of Account instances" do
    accounts = Transactions.create_accounts_with_balance(BALANCES_CSV_DATA)
    expect(accounts.all?(Account)).to eq(true)
  end

  it "returns list of Accounts with account number and balance, given csv contents" do
    accounts = Transactions.create_accounts_with_balance(BALANCES_CSV_DATA)
    expect(accounts.length).to eq(2)
    expect(accounts.any?{ |account| account.account_number == "1234567812345678" && account.balance == 5000.0}).to eq(true)
    expect(accounts.any?{ |account| account.account_number == "2345678123456789" && account.balance == 50.0}).to eq(true)
  end
end

describe ".load_company_balances" do
  it "returns Company with updated accounts" do
    company = Company.new("Test Company")

    expect(company.accounts).to eq([])

    Transactions.load_company_balances(company, BALANCES_CSV_FILE)
    expect(company.accounts.length).to eq(2)
    expect(company.accounts.any?{ |account| account.account_number == "1111234522226789" && account.balance == 5000.0}).to eq(true)
    expect(company.accounts.any?{ |account| account.account_number == "1111234522221234" && account.balance == 10000.0}).to eq(true)
  end

end