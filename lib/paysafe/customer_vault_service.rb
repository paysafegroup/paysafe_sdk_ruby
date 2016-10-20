<<-DOC
 * Copyright (c) 2016 Paysafe
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
 * associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
 * NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
DOC

module Paysafe
  class CustomerVaultService
    def initialize client
      @client = client # PaysafeApiClient
      @uri = "/customervault/v1" # URI for customer vault API
    end

    def monitor
      request = Request.new({
        method: Request::GET,
        uri: "/customervault/monitor"
      })
      @client.process_request(request)[:status] == "READY"
    end

    def create_singleUseToken profile
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/singleusetokens"),
      body: profile.get(
      required = ['card']
      )
      )

      @client.process_request request
    end

    ###########
    # Profile
    ###########

    def create_profile profile
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles"),
      body: profile.get(
      #required = ['merchantCustomerId', 'locale', 'singleUseToken']
      required = ['merchantCustomerId', 'locale']
      )
      )

      response = @client.process_request request
      CustomerVault::Profile::new response
    end

    def get_profile profile, addresses=false, cards=false, achbankaccounts=false, bacsbankaccounts=false, eftbankaccounts=false, sepabankaccounts=false

      fields = []
      fields << "addresses" if addresses
      fields << "cards" if cards
      fields << "achbankaccounts" if achbankaccounts
      fields << "bacsbankaccounts" if bacsbankaccounts
      fields << "eftbankaccounts" if eftbankaccounts
      fields << "sepabankaccounts" if sepabankaccounts

      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" + profile.id),
      query: fields.length ? { fields: fields.join(",") } : {}
      )

      response = @client.process_request request
      CustomerVault::Profile::new response
    end

    def update_profile profile
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + profile.id),
      body: profile.get(
      required = ['merchantCustomerId', 'locale'],
      ignore = ['id']
      )
      )

      response = @client.process_request request
      CustomerVault::Profile::new response
    end

    def delete_profile profile
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + profile.id)
      )

      response = @client.process_request request
      CustomerVault::Profile::new response
    end

    ###########
    # Cards
    ###########

    def get_card card
      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" + card.profileID + "/cards/" + card.id)
      )

      response = @client.process_request request
      response[:profileID] = card.profileID

      CustomerVault::Card::new response
    end

    def create_card card
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + card.profileID + "/cards"),
      body: card.get(
      required = ['cardNum', 'cardExpiry'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      CustomerVault::Card::new response
    end

    def update_card card
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + card.profileID + "/cards/" + card.id),
      body: card.get(
      required = [],
      ignore = ['profileID', 'id']
      )
      )

      response = @client.process_request request
      response[:profileID] = card.profileID

      CustomerVault::Card::new response
    end

    def delete_card card
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + card.profileID + "/cards/" + card.id)
      )

      response = @client.process_request request
      CustomerVault::Card::new response
    end

    ###########
    # Addresses
    ###########

    def create_address address
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + address.profileID + "/addresses"),
      body: address.get(
      required = ['country'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = address.profileID

      CustomerVault::Address::new response
    end

    def update_address address
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + address.profileID + "/addresses/" + address.id),
      body: address.get(
      required = ['country'],
      ignore = ['profileID', 'id']
      )
      )

      response = @client.process_request request
      response[:profileID] = address.profileID

      address_obj = CustomerVault::Address::new response
    end

    def delete_address address
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + address.profileID + "/addresses/" + address.id)
      )

      response = @client.process_request request
      CustomerVault::Address::new response
    end

    def get_address address
      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" + address.profileID + "/addresses/" + address.id)
      )

      response = @client.process_request request
      response[:profileID] = address.profileID

      CustomerVault::Address::new response
    end

    ##################
    #BACS Bank Account
    ##################

    def create_bacs_bank_account bacs_bank_account
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + bacs_bank_account.profileID + "/bacsbankaccounts"),
      body: bacs_bank_account.get(
      required = ['accountHolderName', 'sortCode', 'accountNumber', 'billingAddressId'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = bacs_bank_account.profileID

      CustomerVault::BacsBankAccount::new response
    end

    def create_bacs_bank_account_with_mandate bacs_bank_account_mandate
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + bacs_bank_account_mandate.profileID + "/bacsbankaccounts"),
      body: bacs_bank_account_mandate.get(
      required = ['accountHolderName', 'sortCode', 'accountNumber', 'billingAddressId','mandates'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = bacs_bank_account_mandate.profileID

      CustomerVault::BacsBankAccount::new response
    end

    def get_bacs_bank_account bacs_bank_account
      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" + bacs_bank_account.profileID + "/bacsbankaccounts/" + bacs_bank_account.id)
      )

      response = @client.process_request request
      response[:profileID] = bacs_bank_account.profileID

      CustomerVault::BacsBankAccount::new response
    end

    def update_bacs_bank_account bacs_bank_account
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + bacs_bank_account.profileID + "/bacsbankaccounts/" + bacs_bank_account.id),
      body: bacs_bank_account.get(
      required = ['accountHolderName', 'sortCode', 'accountNumber', 'billingAddressId'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = bacs_bank_account.profileID

      CustomerVault::BacsBankAccount::new response
    end

    def delete_bacs_bank_account bacs_bank_account
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + bacs_bank_account.profileID + "/bacsbankaccounts/" + bacs_bank_account.id)
      )

      response = @client.process_request request
      CustomerVault::BacsBankAccount::new response
    end

    #################
    #SEPA Bank Account
    #################

    def create_sepa_bank_account sepa_bank_account
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + sepa_bank_account.profileID + "/sepabankaccounts"),
      body: sepa_bank_account.get(
      required = ['accountHolderName', 'iban','billingAddressId'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = sepa_bank_account.profileID

      CustomerVault::SepaBankAccount::new response
    end

    def create_sepa_bank_account_with_mandate sepa_bank_account_mandate
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + sepa_bank_account_mandate.profileID + "/sepabankaccounts"),
      body: sepa_bank_account_mandate.get(
      required = ['accountHolderName', 'iban','billingAddressId','mandates'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = sepa_bank_account_mandate.profileID

      CustomerVault::SepaBankAccount::new response
    end

    def get_sepa_bank_account sepa_bank_account
      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" + sepa_bank_account.profileID + "/sepabankaccounts/" + sepa_bank_account.id)
      )

      response = @client.process_request request
      response[:profileID] = sepa_bank_account.profileID

      CustomerVault::SepaBankAccount::new response
    end

    def update_sepa_bank_account sepa_bank_account
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + sepa_bank_account.profileID + "/sepabankaccounts/" + sepa_bank_account.id),
      body: sepa_bank_account.get(
      required = ['accountHolderName', 'iban','billingAddressId'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = sepa_bank_account.profileID

      CustomerVault::SepaBankAccount::new response
    end

    def delete_sepa_bank_account sepa_bank_account
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + sepa_bank_account.profileID + "/sepabankaccounts/" + sepa_bank_account.id)
      )

      @client.process_request request
      true
    end

    ##################
    #EFT Bank Account
    ##################

    def create_eft_bank_account eft_bank_account
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + eft_bank_account.profileID + "/eftbankaccounts"),
      body: eft_bank_account.get(
      required = ['accountHolderName', 'accountNumber', 'transitNumber', 'billingAddressId', 'institutionId'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = eft_bank_account.profileID

      CustomerVault::EftBankAccount::new response
    end

    def get_eft_bank_account eft_bank_account
      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" + eft_bank_account.profileID + "/eftbankaccounts/" + eft_bank_account.id)
      )

      response = @client.process_request request
      response[:profileID] = eft_bank_account.profileID

      CustomerVault::EftBankAccount::new response
    end

    def update_eft_bank_account eft_bank_account
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + eft_bank_account.profileID + "/eftbankaccounts/" + eft_bank_account.id),
      body: eft_bank_account.get(
      required = ['accountHolderName', 'accountNumber', 'transitNumber', 'billingAddressId', 'institutionId'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = eft_bank_account.profileID

      CustomerVault::EftBankAccount::new response
    end

    def delete_eft_bank_account eft_bank_account
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + eft_bank_account.profileID + "/eftbankaccounts/" + eft_bank_account.id)
      )

      @client.process_request request
      true
    end

    ##############
    #Sepa Mandates
    ##############

    def create_sepa_mandate mandate
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + mandate.profileID + "/sepabankaccounts/" + mandate.bankAccountId + "/mandates"),
      body: mandate.get(
      required = ['reference'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request

      response[:profileID] = mandate.profileID
      CustomerVault::Mandate::new response
    end

    def get_mandate mandate
      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" +  mandate.profileID + "/mandates/" + mandate.id)
      )

      response = @client.process_request request
      response[:profileID] = mandate.profileID

      CustomerVault::Mandate::new response
    end

    def update_mandate mandate
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + mandate.profileID + "/mandates/" + mandate.id),
      body: mandate.get(
      required = ['status'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = mandate.profileID

      CustomerVault::Mandate::new response
    end

    def delete_mandate mandate
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + mandate.profileID + "/mandates/" + mandate.id)
      )

      @client.process_request request
      true
    end

    ##############
    #Bacs Mandates
    ##############

    def create_bacs_mandate mandate
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + mandate.profileID + "/bacsbankaccounts/" + mandate.bankAccountId + "/mandates"),
      body: mandate.get(
      required = ['reference'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request

      response[:profileID] = mandate.profileID
      CustomerVault::Mandate::new response
    end

    ####################
    # ACH Bank Account
    ####################

    def create_ach_bank_account ach_bank_account
      request = Request.new(
      method: Request::POST,
      uri: prepare_uri("/profiles/" + ach_bank_account.profileID + "/achbankaccounts"),
      body: ach_bank_account.get(
      required = ['accountHolderName', 'accountNumber', 'routingNumber', 'billingAddressId', 'accountType'],
      ignore = ['profileID']
      )
      )

      response = @client.process_request request
      response[:profileID] = ach_bank_account.profileID

      CustomerVault::AchBankAccount::new response
    end

    def get_ach_bank_account ach_bank_account
      request = Request.new(
      method: Request::GET,
      uri: prepare_uri("/profiles/" + ach_bank_account.profileID + "/achbankaccounts/" + ach_bank_account.id)
      )

      response = @client.process_request request
      response[:profileID] = ach_bank_account.profileID

      CustomerVault::AchBankAccount::new response
    end

    def update_ach_bank_account ach_bank_account
      request = Request.new(
      method: Request::PUT,
      uri: prepare_uri("/profiles/" + ach_bank_account.profileID + "/achbankaccounts/" + ach_bank_account.id),
      body: ach_bank_account.get(
      required = ['accountHolderName', 'routingNumber', 'billingAddressId', 'accountType'],
      ignore = ['profileID', 'id']
      )
      )

      response = @client.process_request request
      response[:profileID] = ach_bank_account.profileID

      ach_bank_account_obj = CustomerVault::AchBankAccount::new response
    end

    def delete_ach_bank_account ach_bank_account
      request = Request.new(
      method: Request::DELETE,
      uri: prepare_uri("/profiles/" + ach_bank_account.profileID + "/achbankaccounts/" + ach_bank_account.id)
      )

      @client.process_request request
      true
    end

    private

    # Prepare URI for submission to the API
    def prepare_uri path
      "#{@uri}#{path}"
    end
  end
end