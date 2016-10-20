module Paysafe
  module CustomerVault
    class Address < JsonObject
      attr_accessor :id
      attr_accessor :nickName
      attr_accessor :status
      attr_accessor :street
      attr_accessor :street2
      attr_accessor :city
      attr_accessor :country
      attr_accessor :state
      attr_accessor :zip
      attr_accessor :recipientName
      attr_accessor :phone
      attr_accessor :defaultShippingAddressIndicator
      attr_accessor :error
      attr_accessor :links
      attr_accessor :profileID
    end
  end
end