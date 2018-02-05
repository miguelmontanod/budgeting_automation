require 'site_prism'

class Budgeting < SitePrism::Page

	@@topMenuButton="//a[contains(text(),'%s')]"
	@@totalInflow="(//div[contains(@class, '_3S2Fs')]//div[1])[1]"
	@@totalOutflow="(//div[contains(@class, '_3S2Fs')]//div[1])[2]"
	@@workingBalance="(//div[contains(@class, '_3S2Fs')]//div[1])[3]"
	@@categorySelectOptions="//select[contains(@name,'categoryId')]//option[contains(text(),'%s')]"
	@@addButton="//button[contains(text(),'Add')]"
	@@activeTopMenuButton="//div[contains(@class,'_2uRHS')]//a[contains(text(),'%s') and contains(@class,'_1ZQm-')]"
	@@lastItemCategory="((//table[contains(@class,'opmhI')]/tbody/tr)[last()]/td)[1]"
	@@lastItemDescription="((//table[contains(@class,'opmhI')]/tbody/tr)[last()]/td)[2]"
	@@lastItemAmount="((//table[contains(@class,'opmhI')]/tbody/tr)[last()]/td)[3]"
	element :categorySelect, :xpath, "//select[contains(@name,'categoryId')]"
	element :descriptionField, :xpath, "//input[contains(@name,'description')]"
	element :itemAmount, :xpath, "//input[contains(@name,'value')]"

	#
	# Opens an application section by clicking
	# 	on the specified button on the top menu
	#
	# Input: 
	# => button: a string value (Budget, Report)
	# Output:
	# => boolean
	#
	def clickTopMenuButton(button)
		result = true
		begin
			page.find(:xpath, @@topMenuButton % button).click
		rescue
			result = false
		end
		return result
	end

	#
	# Gets the total income from the bottom table
	#
	# Output:
	# => numeric
	#
	def getTotalInflow()
		totalInflow = page.find(:xpath, @@totalInflow).text.gsub(/[^\d\.-]/,'').to_i
		return totalInflow
	end

	#
	# Gets the total outflow from the bottom table
	#
	# Output:
	# => numeric
	#
	def getTotalOutflow()
		totalOutflow = page.find(:xpath, @@totalOutflow).text.gsub(/[^\d\.-]/,'').to_i
		return totalOutflow
	end

	#
	# Gets the working balance value from the bottom table
	# 
	# Output:
	# => numeric
	#
	def getWorkingBalance()
		workingBalance = page.find(:xpath, @@workingBalance).text.gsub(/[^\d\.-]/,'').to_i
		return workingBalance
	end

	#
	# Verifies if the new entry has been registered
	#
	# Input:
	# => category: string
	# => description: string
	# => amount: numeric
	# Output:
	# => boolean
	#
	def verifyNewEntry(description,category,amount)
		result = false
		actualCat = page.find(:xpath, @@lastItemCategory).text
		actualDes = page.find(:xpath, @@lastItemDescription).text
		actualAmo = page.find(:xpath, @@lastItemAmount).text.gsub(/[^\d\.-]/,'').gsub("-", "").to_i
		begin
			result = true if (actualCat == category and actualDes == description and actualAmo == amount.to_i)
		rescue RSpec::Expectations::ExpectationNotMetError
		end
		rArray = {"actualCat"=>actualCat,"actualDes"=>actualDes,"actualAmo"=>actualAmo,"result"=>result}
		return rArray
	end

	#
	# Verifies if the income has increased
	#
	# Input:
	# => oldInflow: int
	# => newInflow: int
	# Output:
	# => boolean
	#
	def totalInflowIncreased(oldInflow,newInflow)
		return true if newInflow > oldInflow
	end

	#
	# Verifies if the total has increased
	#
	# Input:
	# => oldInflow: int
	# => newInflow: int
	# Output:
	# => boolean
	#
	def totalAmountIncreased(oldValue,newValue)
		return true if newValue > oldValue
	end

	#
	# Verifies if the working balance has increased
	#
	# Input:
	# => oldWorkingBalance: int
	# => newWorkingBalance: int
	# Output:
	# => boolean
	#
	def totalAmountDecreased(oldValue,newValue)
		return true if newValue < oldValue
	end

	#
	# Registers a new entry, either income or expense
	#
	# Input:
	# => amount: numeric value
	# => description: text value
	# Output:
	# => boolean
	#
	def registerEntry(category,amount,description)
		categorySelect.click
		page.find(:xpath, @@categorySelectOptions % category).click
		descriptionField.set(description)
		itemAmount.set(amount)
		page.find(:xpath, @@addButton).click
		result = true if verifyIfSubmitDisabled != true
		return result
	end

	#
	# Verifies if the Add button is disabled
	# 
	# Output: 
	# => boolean
	def verifyIfSubmitDisabled()
		result = page.find(:xpath, @@addButton)[:disabled]
		return result
	end

	#
	# Verify if specified top menu button is active
	# 
	# Input: 
	# => button: string (Budget, Report)
	# Output: 
	# => boolean
	def activeMenuButton(button)
		result = page.first(:xpath, @@activeTopMenuButton % button)
		return true unless result.nil?
	end
end