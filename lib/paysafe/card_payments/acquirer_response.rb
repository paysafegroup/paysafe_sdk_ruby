module Paysafe
  module CardPayments
    class AcquirerResponse < JsonObject
      attr_accessor :code
      attr_accessor :responseCode
      attr_accessor :avsCode
      attr_accessor :balanceResponse
      attr_accessor :batchNumber
      attr_accessor :effectiveDate
      attr_accessor :financingType
      attr_accessor :gracePeriod
      attr_accessor :plan
      attr_accessor :seqNumber
      attr_accessor :term
      attr_accessor :terminalId
      attr_accessor :responseId
      attr_accessor :requestId
      attr_accessor :description
      attr_accessor :authCode
      attr_accessor :txnDateTime
      attr_accessor :referenceNbr
      attr_accessor :responseReasonCode
      attr_accessor :cvv2Result
      attr_accessor :mid
    end
  end
end