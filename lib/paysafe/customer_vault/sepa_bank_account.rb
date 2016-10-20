module Paysafe
  module CustomerVault
  class SepaBankAccount < BankAccount
    attr_accessor :iban
     attr_accessor :bic
    attr_accessor :mandates
  end
  end
end 