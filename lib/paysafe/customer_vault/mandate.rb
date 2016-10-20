module Paysafe
  module CustomerVault
    class Mandate < JsonObject
      
      attr_accessor :id
      attr_accessor :reference
      attr_accessor :bankAccountId
      attr_accessor :status
      attr_accessor :paymentToken
      attr_accessor :accountNumber
      attr_accessor :statusChangeDate
      attr_accessor :statusReasonCode
      attr_accessor :statusReason
      attr_accessor :profileID
    end
  end
end     