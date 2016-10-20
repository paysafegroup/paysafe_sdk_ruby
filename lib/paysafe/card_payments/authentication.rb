module Paysafe
  module CardPayments
    class Authentication < JsonObject
      attr_accessor :eci
      attr_accessor :cavv
      attr_accessor :xid
      attr_accessor :threeDEnrollment
      attr_accessor :threeDResult
      attr_accessor :signatureStatus
    end
  end
end