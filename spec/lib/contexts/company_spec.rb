require './lib/contexts/company.rb'
require './lib/contexts/account.rb'

describe Company do
  context ".new" do
    it "returns new instance of Company" do
      name = "Pizza Hut"
      company = Company.new(name)

      expect(company).to be_a(Company)
      expect(company.name).to eq(name)
      expect(company.accounts).to eq([])
    end
  end

  context ".name" do
    it "gets value of name" do
      name = "Pizza Hut"
      company = Company.new(name)

      expect(company.name).to eq(name)
    end
  end

  context ".accounts" do
    it "gets accounts" do
      name = "Pizza Hut"
      company = Company.new(name)

      expect(company.accounts).to eq([])
    end

    it "sets accounts" do
      name = "Pizza Hut"
      company = Company.new(name)

      expect(company.accounts).to eq([])

      account = Account.new("0123456789012345", 10.0)
      company.accounts = [account]

      expect(company.accounts).to eq([account])
    end
  end

  context ".add_account" do
    it "adds an account" do
      name = "Pizza Hut"
      acc_number = "0123456789012345"
      balance = 100.00
      company = Company.new(name)
      expect(company.accounts).to eq([])

      company.add_account(acc_number, balance)
      expect(company.accounts[0]).to be_a(Account)
      expect(company.accounts[0].account_number).to eq(acc_number)
      expect(company.accounts[0].balance).to eq(balance)
    end
  end

  describe ".get_account_by_lookup" do
    it "returns the Account from Company, given account number lookup" do
      company = Company.new("Test Company")
      account = Account.new("1234567812345678", 100.0)
      company.accounts = [account]

      expect(company.get_account_by_lookup("1234567812345678")).to eq(account)
    end
  end
end