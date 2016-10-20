 module Paysafe
  module DirectDebit
	class StandaloneCredits < JsonObject
		attr_accessor :id
    	attr_accessor :merchantRefNum
    	attr_accessor :amount
    	attr_accessor :ach
    	attr_accessor :eft
    	attr_accessor :bacs
		attr_accessor :profile
	    attr_accessor :billingDetails
	    attr_accessor :shippingDetails
	    attr_accessor :customerIp
	    attr_accessor :dupCheck
		attr_accessor :txnTime
	    attr_accessor :currencyCode
	    attr_accessor :error
	    attr_accessor :status

		attr_accessor :links
	    attr_accessor :pagination
	    attr_accessor :dupCheck
	    attr_accessor :customerIp
	end
  end
end