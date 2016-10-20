module Paysafe
  module CustomerVault
    class Profile < JsonObject
      attr_accessor :id
      attr_accessor :status
      attr_accessor :merchantCustomerId
      attr_accessor :locale
      attr_accessor :firstName
      attr_accessor :middleName
      attr_accessor :lastName
      attr_accessor :dateOfBirth
      attr_accessor :ip
      attr_accessor :gender
      attr_accessor :nationality
      attr_accessor :email
      attr_accessor :phone
      attr_accessor :cellPhone
      attr_accessor :paymentToken
      attr_accessor :addresses
      attr_accessor :cards
      attr_accessor :error
      attr_accessor :links
    end
  end
end