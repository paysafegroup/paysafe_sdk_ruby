module Paysafe
  module CardPayments
    class Profile < JsonObject
      attr_accessor :firstName
      attr_accessor :lastName
      attr_accessor :email
    end
  end
end