module Paysafe
  module DirectDebit
    class Pagination < JsonObject
      attr_accessor :limit
      attr_accessor :offset
      attr_accessor :startDate
      attr_accessor :endDate
    end
  end
end