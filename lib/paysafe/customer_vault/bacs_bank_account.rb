module Paysafe
  module CustomerVault
    class BacsBankAccount < BankAccount
      attr_accessor :sortCode
      attr_accessor :mandates

    end
  end
end 