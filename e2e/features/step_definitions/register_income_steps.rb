Given("I go to the budgeting app page") do
  visit "/"
end

Given(/^I am on the "([^"]*)" app page$/) do |button|
  initBudgetingPage
  expect(@budgetPage.activeMenuButton(button)).to be(true), "The #{button} page is not active"
end

When(/^I click on the top menu button "([^"]*)"$/) do |button|
  initBudgetingPage
  @budgetPage.clickTopMenuButton(button)
end

When(/^I register a new "([^"]*)" of "([^"]*)" usd from "([^"]*)"$/) do |category, amount, description|
  initBudgetingPage
  oldInflow = @budgetPage.getTotalInflow()
  oldWorkingBalance = @budgetPage.getWorkingBalance()
  registerNewIncome = @budgetPage.registerEntry(category,amount,description)
  newInflow = @budgetPage.getTotalInflow()
  newWorkingBalance = @budgetPage.getWorkingBalance()
  expect(registerNewIncome).to be(true), "Could not register an income of #{amount} from #{description}"
  expect(@budgetPage.totalAmountIncreased(oldInflow,newInflow)).to be(true), "The income value has not increased"
  expect(@budgetPage.totalAmountIncreased(oldWorkingBalance,newWorkingBalance)).to be(true), "The Working Balance value has not increased"
end

When(/^I register a new "([^"]*)" expense of "([^"]*)" usd for "([^"]*)"$/) do |description, amount, category|
  initBudgetingPage
  oldOutflow = @budgetPage.getTotalOutflow()
  oldWorkingBalance = @budgetPage.getWorkingBalance()
  registerNewExpense = @budgetPage.registerEntry(category,amount,description)
  newOutflow = @budgetPage.getTotalOutflow()
  newWorkingBalance = @budgetPage.getWorkingBalance()
  expect(registerNewExpense).to be(true), "Could not register a #{category} expense of #{amount} for #{description}"
  expect(@budgetPage.totalAmountIncreased(oldOutflow,newOutflow)).to be(true), "The Total Outflow value has not increased from #{oldOutflow} to #{newOutflow}"
  expect(@budgetPage.totalAmountDecreased(oldWorkingBalance,newWorkingBalance)).to be(true), "The Working Balance value has not decreased from #{oldWorkingBalance} to #{newWorkingBalance}"
end

When(/^I verify that the new "([^"]*)" entry for "([^"]*)" of "([^"]*)" was added$/) do |description,category,amount|
  initBudgetingPage
  newEntry = @budgetPage.verifyNewEntry(description,category,amount)
  expect(newEntry['result']).to be(true), "Either the new entry has not been added, or something went wrong with the values. Last entry: Category: #{newEntry['actualCat']}, Description: #{newEntry['actualDes']}, Amount: #{newEntry['actualAmo']}"
end

## Methods
def initBudgetingPage()
  @budgetPage = Budgeting.new()
end