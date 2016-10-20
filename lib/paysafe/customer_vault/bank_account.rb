module Paysafe
  module CustomerVault
    class BankAccount < JsonObject
    	attr_accessor :id
    	attr_accessor :nickName
    	attr_accessor :merchantRefNum
    	attr_accessor :status
    	attr_accessor :statusReason
    	attr_accessor :accountNumber
    	attr_accessor :accountHolderName
    	attr_accessor :lastDigits
    	attr_accessor :billingAddressId
    	attr_accessor :paymentToken
    	attr_accessor :profileID
    end
   end
end   	