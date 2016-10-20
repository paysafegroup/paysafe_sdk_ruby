module Paysafe
  module DirectDebit
	class AchBankAccount < JsonObject
		attr_accessor :accountNumber
    	attr_accessor :accountHolderName
    	attr_accessor :transitNumber
		attr_accessor :institutionId
		attr_accessor :lastDigits
	    attr_accessor :paymentToken
	end
  end
end