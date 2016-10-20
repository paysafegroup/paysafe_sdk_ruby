module Paysafe
  module CardPayments
    class ShippingDetails < JsonObject
      attr_accessor :recipientName
      attr_accessor :street
      attr_accessor :street2
      attr_accessor :city
      attr_accessor :state
      attr_accessor :country
      attr_accessor :zip
      attr_accessor :phone
      attr_accessor :carrier
      attr_accessor :shipMethod
    end
  end
end