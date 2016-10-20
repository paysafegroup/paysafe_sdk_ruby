module Paysafe
  module DirectDebit
	class SepaBankAccount < JsonObject
		attr_accessor :mandateReference
    	attr_accessor :accountHolderName
    	attr_accessor :iban
	end
  end
end