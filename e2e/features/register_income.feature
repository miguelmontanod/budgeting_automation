Feature: Register budget transactions
 
Scenario: Register a new income entry
	Given I go to the budgeting app page
		And I am on the "Budget" app page
		And I register a new "Income" of "70" usd from "Paycheck"
	Then I verify that the new "Paycheck" entry for "Income" of "70" was added

Scenario: Register an item with a high amount
	Given I go to the budgeting app page
		And I am on the "Budget" app page
	When I register a new "Income" of "11111111111111111" usd from "Paycheck"
	Then I verify that the new "Paycheck" entry for "Income" of "11111111111111111" was added 
	# The previous test will fail, since there's a bug in the app. Last two characters wil lbe turned into 0.

Scenario: Bottom table functionality
	Given I go to the budgeting app page
		And I am on the "Budget" app page
	When I register a new "Income" of "100" usd from "Paycheck"
	Then I verify that the new "Paycheck" entry for "Income" of "100" was added
	When I register a new "Test Description" expense of "200" usd for "Car"
	Then I verify that the new "Test Description" entry for "Car" of "200" was added