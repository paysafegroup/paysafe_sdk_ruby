module Paysafe
  module CardPayments
    class Verification < JsonObject
      attr_accessor :id
      attr_accessor :merchantRefNum
      attr_accessor :childAccountNum
      attr_accessor :card
      attr_accessor :authCode
      attr_accessor :profile
      attr_accessor :billingDetails
      attr_accessor :customerIp
      attr_accessor :merchantDescriptor
      attr_accessor :description
      attr_accessor :currencyCode
      attr_accessor :avsResponse
      attr_accessor :cvvVerification
      attr_accessor :txnTime
      attr_accessor :dupCheck
      attr_accessor :status
      attr_accessor :riskReasonCode
      attr_accessor :acquirerResponse
      attr_accessor :error
      attr_accessor :links

      def self.get_pageable_array_key
        "verifications"
      end
    end
  end
end