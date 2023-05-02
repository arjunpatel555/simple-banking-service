require './lib/contexts/account.rb'

describe Account do
  context ".new" do
    it "returns a new instance with account number and balance" do
      acc_number = "1234567812345678"
      bal = 0
      account = Account.new(acc_number, bal)

      expect(account).to be_a(Account)
      expect(account.account_number).to eq(acc_number)
      expect(account.balance).to eq(bal)
    end

    it "raises an error when account number is invalid format" do
      bal = 0

      expect { Account.new(1, bal) }.to raise_error(RuntimeError)
      expect { Account.new("123", bal) }.to raise_error(RuntimeError)
      expect { Account.new("1 not a string of digits", bal) }.to raise_error(RuntimeError)
    end

    it "raises an error when balance is invalid format" do
      acc_number = 1234567812345678

      expect { Account.new(acc_number, "not numeric") }.to raise_error(RuntimeError)
    end
  end

  context ".account_number" do
    it "gets value of account_number" do
      acc_number = "1234567812345678"
      bal = 0
      account = Account.new(acc_number, bal)

      expect(account.account_number).to eq(acc_number)
    end

    it "sets value of account_number" do
      init_account = "1234567812345678"
      new_account = "0123456781234567"
      bal = 0
      account = Account.new(init_account, bal)
      expect(account.account_number).to eq(init_account)

      account.account_number = new_account
      expect(account.account_number).to eq(new_account)
    end

    it "raises an error when setting account number with invalid value" do
      bal = 0

      expect { Account.new(1, bal) }.to raise_error(RuntimeError)
      expect { Account.new("123", bal) }.to raise_error(RuntimeError)
      expect { Account.new("1 not a string of digits", bal) }.to raise_error(RuntimeError)
    end
  end

  context ".balance" do
    it "gets value of balance" do
      acc_number = "1234567812345678"
      bal = 0
      account = Account.new(acc_number, bal)

      expect(account.balance).to eq(bal)
    end

    it "sets value of balance to positive numeric" do
      account = "1234567812345678"
      init_bal = 0
      new_bal = 123.23
      account = Account.new(account, init_bal)
      expect(account.balance).to eq(init_bal)

      account.balance = new_bal
      expect(account.balance).to eq(new_bal)
    end

    it "sets value of balance to negative numeric" do
      account = "1234567812345678"
      init_bal = 0
      new_bal = -123.23
      account = Account.new(account, init_bal)
      expect(account.balance).to eq(init_bal)

      account.balance = new_bal
      expect(account.balance).to eq(new_bal)
    end

    it "raises an error when setting account number with invalid value" do
      account = "1234567812345678"

      expect { Account.new(account, "not numeric") }.to raise_error(RuntimeError)
      # TO.DO:AP - Do something about signed zeroes
      # expect { Account.new(account, -0) }.to raise_error(RuntimeError)
    end
  end
end