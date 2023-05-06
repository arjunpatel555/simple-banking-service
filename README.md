# Simple Banking Service

## How to run
- To run the application
  - run `bundle install` to install dependencies
  - run `ruby lib/main.rb ./acc_balance.csv ./transactions.csv`

- To run the tests
  - run `rspec`
## User Stories
- As a user, I can load a csv of account balances for a single company
- As a user, I can load a csv file that will transfer money between two accounts

## Constraints
- Implement system to load account balances for a single company and then accept their transactions
- Money cannot be transferred between accounts, if the transaction puts the ‘from’ account into negative balance (< $0)
- Accounts are identified by a 16-digit number (business constraint, not domain constraint)

## Decisions
- Implement a very simple solution where balance and transaction CSV’s are provided and executed with no database
  - Load Account Balances for a single company
    - No requirement to handle multiple csv uploads for multiple companies
  - Did not implement a database. 
    - No specific requirement of looking up balances or managing multiple companies post-application execution
    - To keep within my time constraints
- CSV Reader module
    - Keep the CSV functions together
    - Keeps all references to the gem `csv` in one file
        - If we were to use another gem for csv parsing, then we would not have to go through the codebase to refactor.
- Company Class
  - `name` validation as a string
  - `accounts` validation as instances of Account
- Account Class
  - `account_number` validated as a string, so the starting digit can be a “0”
  - `balance` validated as Numeric (float) for decimal calculations
- Error handling
  - All validation errors produce the exception `RuntimeError`
    - The decision was made to not create custom exception handling to keep within time constraints

## Improvements

- CSV File
    - Enforce the use of headers
      - Current implementation trusts the user to supply data in the correct format
      - Headers would provide a good safe guard so that the code does not rely on the column orders for the correct data
- Error handling
  - Validation errors currently raise the exception `RuntimeError`, which is very generic
    - Current tests are a little flakey for checking if an error is raised, as all errors produce `RuntimeError`
    - Improvement would be to create custom exception classes to handle validation errors
- Database
  - Nice to have, although deemed as not required (as noted in Decisions)
  
  