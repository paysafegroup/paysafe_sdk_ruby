module Paysafe
  module CardPayments
    class Settlement < JsonObject
      attr_accessor :id
      attr_accessor :merchantRefNum
      attr_accessor :amount
      attr_accessor :availableToRefund
      attr_accessor :childAccountNum
      attr_accessor :txnTime
      attr_accessor :dupCheck
      attr_accessor :status
      attr_accessor :riskReasonCode
      attr_accessor :acquirerResponse
      attr_accessor :error
      attr_accessor :links
      attr_accessor :authorizationID

      def self.get_pageable_array_key
        "settlements"
      end
    end
  end
end