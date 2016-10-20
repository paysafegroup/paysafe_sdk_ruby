module Paysafe
  module CardPayments
    class Authorization < JsonObject
      attr_accessor :id
      attr_accessor :merchantRefNum
      attr_accessor :amount
      attr_accessor :settleWithAuth
      attr_accessor :availableToSettle
      attr_accessor :childAccountNum
      attr_accessor :card
      attr_accessor :authentication
      attr_accessor :authCode
      attr_accessor :profile
      attr_accessor :billingDetails
      attr_accessor :shippingDetails
      attr_accessor :recurring
      attr_accessor :customerIp
      attr_accessor :dupCheck
      attr_accessor :keywords
      attr_accessor :merchantDescriptor
      attr_accessor :accordD
      attr_accessor :description
      attr_accessor :masterPass
      attr_accessor :txnTime
      attr_accessor :currencyCode
      attr_accessor :avsResponse
      attr_accessor :cvvVerification
      attr_accessor :status
      attr_accessor :riskReasonCode
      attr_accessor :acquirerResponse
      attr_accessor :visaAdditionalAuthData
      attr_accessor :settlements
      attr_accessor :error
      attr_accessor :links

      def self.get_pageable_array_key
        "auths"
      end
    end
  end
end