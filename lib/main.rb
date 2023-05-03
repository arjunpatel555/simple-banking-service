require_relative 'helpers/csv_reader.rb'
require_relative 'contexts/company.rb'
require_relative 'transactions'

include CSV_Reader
include Transactions

shell_input_args = ARGV
file_balances = shell_input_args[0]
file_transactions = shell_input_args[1]

# balances
print "Loading balance from #{file_balances}\n"
company = Company.new("Alpha Sales")
load_company_balances(company, file_balances)
print "Company Balances:\n"
company.accounts.each{ |account| print"acc_number: #{account.account_number} bal: #{account.balance}\n"}