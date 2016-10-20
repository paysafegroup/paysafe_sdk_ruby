module Paysafe
  module DirectDebit
	class BacsBankAccount < JsonObject
		attr_accessor :accountNumber
    	attr_accessor :accountHolderName
    	attr_accessor :sortCode
		attr_accessor :mandateReference
		attr_accessor :paymentToken
		attr_accessor :lastDigits
	end
  end
end