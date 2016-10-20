module Paysafe
  module CardPayments
    class Card < JsonObject
      attr_accessor :paymentToken
      attr_accessor :cardNum
      attr_accessor :type
      attr_accessor :lastDigits
      attr_accessor :cardExpiry
      attr_accessor :cvv
      attr_accessor :track1
      attr_accessor :track2
    end
  end
end