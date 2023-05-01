require './lib/contexts/company.rb'

describe Company do
  context ".new/2" do
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
    it "gets value of accounts" do
      name = "Pizza Hut"
      company = Company.new(name)

      expect(company.accounts).to eq([])
    end

    it "sets value of accounts" do
      name = "Pizza Hut"
      init_accounts = [1, 2, 3]
      new_accounts = [4]
      company = Company.new(name, init_accounts)
      expect(company.accounts).to eq(init_accounts)

      company.accounts = company.accounts + new_accounts
      expect(company.accounts).to eq([1, 2, 3, 4])
    end
  end
end