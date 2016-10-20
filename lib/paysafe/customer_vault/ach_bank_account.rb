module Paysafe
  module CustomerVault
	class AchBankAccount < BankAccount
		attr_accessor :routingNumber
	    attr_accessor :accountType
	end
  end
end	