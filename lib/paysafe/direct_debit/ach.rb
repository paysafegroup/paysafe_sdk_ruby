module Paysafe
  module DirectDebit
	class AchBankAccount < JsonObject
		attr_accessor :accountNumber
    	attr_accessor :accountHolderName
    	attr_accessor :lastDigits
		attr_accessor :routingNumber
	    attr_accessor :accountType
	    attr_accessor :payMethod
	    attr_accessor :paymentToken
	    #paymentDescriptor
	end
  end
end