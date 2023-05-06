require './lib/transactions'
require './lib/contexts/company'
require './lib/contexts/account'

include Transactions

BALANCES_CSV_DATA = [["1234567812345678", "5000.00"], ["2345678123456789", "50.00"]]
BALANCES_CSV_FILE = "spec/lib/transactions_balance.csv"
TRANS_CSV_FILE = "spec/lib/transactions_trans.csv"

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
  it "returns Company with updated accounts, given CSV with account numbers and balances" do
    company = Company.new("Test Company")

    expect(company.accounts).to eq([])

    Transactions.load_company_balances(company, BALANCES_CSV_FILE)
    expect(company.accounts.length).to eq(2)
    expect(company.accounts.any?{ |account| account.account_number == "1111234522226789" && account.balance == 5000.0}).to eq(true)
    expect(company.accounts.any?{ |account| account.account_number == "1111234522221234" && account.balance == 10000.0}).to eq(true)
  end
end

describe ".execute_account_transaction" do
  it "updates to_account and from_account objects, by given amount" do
    from_account = Account.new("1111234522221234", 50.0)
    to_account = Account.new("1111234522226789", 100.0)
    amount = 25.0

    expect(from_account.balance).to eq(50.0)
    expect(to_account.balance).to eq(100.0)

    Transactions.execute_account_transaction(from_account, to_account, amount)
    expect(to_account.balance).to eq(125.0)
    expect(from_account.balance).to eq(25.0)
  end

  it "raises an error when the from_account has insufficient balance to transfer amount to to_account" do
    from_account = Account.new("1111234522221234", 50.0)
    to_account = Account.new("1111234522226789", 100.0)
    amount = 100.0

    expect(from_account.balance).to eq(50.0)
    expect(to_account.balance).to eq(100.0)

    expect{ Transactions.execute_account_transaction(from_account, to_account, amount) }.to raise_error(RuntimeError)
  end
end

describe ".process_company_transactions" do
  it "updates Company accounts, given CSV of transactions to process" do
    company = Company.new("Test Company")
    account_1 = Account.new("1111234522226789", 500.0)
    account_2 = Account.new("1212343433335665", 100.0)
    company.accounts = [account_1, account_2]

    transactions = Transactions.process_company_transactions(company, TRANS_CSV_FILE)

    expect(transactions).to eq({successful_transactions: [["1111234522226789", "1212343433335665", "50.00"]], failed_transactions: []})
    expect(account_1.balance).to eq(450.0)
    expect(account_2.balance).to eq(150.0)
  end

  it "returns hash with successful transactions" do
    company = Company.new("Test Company")
    account_1 = Account.new("1111234522226789", 500.0)
    account_2 = Account.new("1212343433335665", 100.0)
    company.accounts = [account_1, account_2]

    transactions = Transactions.process_company_transactions(company, TRANS_CSV_FILE)

    expect(transactions).to eq({successful_transactions: [["1111234522226789", "1212343433335665", "50.00"]], failed_transactions: []})
  end

  it "returns hash with failed transactions" do
    company = Company.new("Test Company")
    company.accounts = []

    transactions = Transactions.process_company_transactions(company, TRANS_CSV_FILE)

    expect(transactions).to eq({successful_transactions: [], failed_transactions: [["1111234522226789", "1212343433335665", "50.00"]]})
  end
end

