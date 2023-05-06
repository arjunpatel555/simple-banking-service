require './lib/contexts/account.rb'

describe Account do
  context ".new" do
    it "returns a new instance with account number and balance" do
      account = create_account()

      expect(account).to be_a(Account)
      expect(account.account_number).to eq("1234567812345678")
      expect(account.balance).to eq(100)
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
      account = create_account()

      expect(account.account_number).to eq("1234567812345678")
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
      account = create_account()

      expect(account.balance).to eq(100)
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
    end
  end

  context ".depost" do
    it "updates the account balance by the depost amount" do
      account = create_account()
      expect(account.deposit(2.5)).to eq(102.5)
    end

    it "raises an error when the deposit amount is invalid" do
      account = create_account()
      expect { account.deposit("not numeric") }.to raise_error(RuntimeError)
      expect { account.deposit(-12) }.to raise_error(RuntimeError)
    end
  end

  context ".withdraw" do
    it "updates the account balance by the withdraw amount" do
      account = create_account()
      expect(account.withdraw(2.5)).to eq(97.5)
    end

    it "raises an error when the withdraw amount is invalid" do
      account = create_account()
      expect { account.withdraw("not numeric") }.to raise_error(RuntimeError)
      expect { account.withdraw(-12) }.to raise_error(RuntimeError)
    end

    it "raises an error when the withdraw amount is greater than the balance" do
       account = create_account()
       expect { account.withdraw(10000.0) }.to raise_error(RuntimeError)
    end
  end
end

private

def create_account
  acc_number = "1234567812345678"
  bal = 100
  Account.new(acc_number, bal)
end

