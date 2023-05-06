require_relative 'helpers/csv_reader.rb'
require_relative 'contexts/company.rb'
require_relative 'transactions'

include Transactions

shell_input_args = ARGV
file_balances = shell_input_args[0]
file_transactions = shell_input_args[1]

def print_company_balances(company)
  company.accounts.each{ |account| print"acc_number: #{account.account_number} bal: #{account.balance}\n"}
end

def print_company_transactions(transactions)
  transactions.each{|transaction| print"#{transaction}\n"}
end

# load balances
print "Loading balance from #{file_balances}\n"
company = Company.new("Alpha Sales")
Transactions.load_company_balances(company, file_balances)
print "Company Balances:\n"
print_company_balances(company)

# process transactions
print "\nProcessing Transactions from #{file_transactions}\n"
company_trans_results = Transactions.process_company_transactions(company, file_transactions)
print "Completed Transactions: #{company_trans_results[:successful_transactions].length}\n"
print_company_transactions(company_trans_results[:successful_transactions])
print "Failed Transactions: #{company_trans_results[:failed_transactions].length}\n"
print_company_transactions(company_trans_results[:failed_transactions])
print "\nUpdated Company Balances:\n"
print_company_balances(company)


