module Paysafe
  module CustomerVault
    class Card < JsonObject
      attr_accessor :id
      attr_accessor :nickName
      attr_accessor :status
      attr_accessor :merchantRefNum
      attr_accessor :holderName
      attr_accessor :cardNum
      attr_accessor :cardBin
      attr_accessor :lastDigits
      attr_accessor :cardExpiry
      attr_accessor :cardType
      attr_accessor :billingAddressId
      attr_accessor :defaultCardIndicator
      attr_accessor :paymentToken
      attr_accessor :error
      attr_accessor :links
      attr_accessor :profileID
      attr_accessor :singleUseToken
    end
  end
end