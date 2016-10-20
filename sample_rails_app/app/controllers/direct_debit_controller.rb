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
require "securerandom"
require "Paysafe"
require "yaml"

class DirectDebitController < ApplicationController
  def index
  end

  ##############
  ## Purchases
  ##############
  def purchase_ach
    if request.post?
      begin
        merchantRefNum = SecureRandom.uuid
        purchase = Paysafe::DirectDebit::Purchase.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          ach: {
          accountHolderName: params[:accountHolderName],
          accountType: params[:accountType],
          accountNumber: params[:accountNumber],
          routingNumber: params[:routingNumber],
          payMethod: params[:payMethod]
          },
          customerIp: params[:customerIp],
          profile: {
          firstName: params[:firstName],
          lastName: params[:lastName],
          email: params[:email]
          },
          billingDetails: {
          street: params[:street],
          city: params[:city],
          state: params[:state],
          country: params[:country],
          zip: params[:zip],
          phone: params[:phone]
          }

        })

        @response = get_ach_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  def purchase_ach_payment_token

    unless request.post?
      create_profile_and_address
      ach_bank_account_obj = Paysafe::CustomerVault::AchBankAccount.new({
        nickName: "John",
        accountNumber: rand(1000..1000000000000),
        routingNumber: "123456789",
        accountHolderName: "XYZ Business",
        billingAddressId: @address_id,
        accountType: "CHECKING",
        profileID: @profile_id
      })

      ach_bank_account = get_client.customer_vault_service.create_ach_bank_account ach_bank_account_obj
      @ach_paymentToken = ach_bank_account.paymentToken
      ach_bank_account_id = ach_bank_account.id
    end

    if request.post?
      begin

        purchase = Paysafe::DirectDebit::Purchase.new(
        {
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          ach: {
          paymentToken: params[:paymentToken],
          payMethod: params[:payMethod]
          }
        })

        @response = get_ach_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  def purchase_eft
    if request.post?
      begin
        purchase = Paysafe::DirectDebit::Purchase.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          eft: {
          accountHolderName: params[:accountHolderName],
          accountNumber: params[:accountNumber],
          transitNumber: params[:transitNumber],
          institutionId: params[:institutionId]
          },
          customerIp: params[:customerIp],
          profile: {
          firstName: params[:firstName],
          lastName: params[:lastName],
          email: params[:email]
          },
          billingDetails: {
          street: params[:street],
          city: params[:city],
          state: params[:state],
          country: params[:country],
          zip: params[:zip],
          phone: params[:phone]
          }

        })

        @response = get_eft_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  def purchase_eft_payment_token
    unless request.post?
      create_profile_and_address
      eft_bank_account_obj = Paysafe::CustomerVault::EftBankAccount.new({
        nickName: "Sally's Bank of Montreal Account",
        accountNumber: rand(1000..100000000000),
        transitNumber: "12345",
        accountHolderName: "Bran",
        billingAddressId: @address_id,
        institutionId: "001",
        profileID: @profile_id
      })

      eft_bank_account = get_client.customer_vault_service.create_eft_bank_account eft_bank_account_obj
      @eft_paymentToken = eft_bank_account.paymentToken
      eft_bank_account_id = eft_bank_account.id
    end

    if request.post?
      begin
        purchase = Paysafe::DirectDebit::Purchase.new(
        {
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          eft: {
          paymentToken: params[:paymentToken]
          }
        })

        @response = get_eft_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  def purchase_bacs
    @accountNumber="19706829"
    @sortCode="070246"
    @mandateReference="ABCDEFGHIJ"
    if request.post?
      begin
        merchantRefNum = SecureRandom.uuid
        purchase = Paysafe::DirectDebit::Purchase.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          bacs: {
          accountHolderName: params[:accountHolderName],
          accountNumber: params[:accountNumber],
          sortCode: params[:sortCode],
          mandateReference: params[:mandateReference]
          },
          customerIp: params[:customerIp],
          profile: {
          firstName: params[:firstName],
          lastName: params[:lastName],
          email: params[:email]
          },
          billingDetails: {
          street: params[:street],
          city: params[:city],
          state: params[:state],
          country: params[:country],
          zip: params[:zip],
          phone: params[:phone],
          sortCode: params[:sortCode]
          }

        })

        @response = get_bacs_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  def purchase_bacs_payment_token
    @bacs_paymentToken = "MgPnKh2gGCQ6p9m"
    if request.post?

      begin

        #bacs_bank_account_id ="5c9941e0-b30b-4cff-b7ff-eee697a76ab3"

        purchase = Paysafe::DirectDebit::Purchase.new(
        {
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          bacs: {
          paymentToken: params[:paymentToken]
          }
        })

        @response = get_bacs_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  def purchase_sepa
    if request.post?
      begin
        merchantRefNum = SecureRandom.uuid
        purchase = Paysafe::DirectDebit::Purchase.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          sepa: {
          mandateReference: "SUBSCRIPTION103",
          accountHolderName: params[:accountHolderName],
          iban: "DE89370400440532013000"
          },
          customerIp: params[:customerIp],
          profile: {
          firstName: params[:firstName],
          lastName: params[:lastName],
          email: params[:email]
          },
          billingDetails: {
          street: params[:street],
          city: params[:city],
          state: params[:state],
          country: params[:country],
          zip: params[:zip],
          phone: params[:phone]
          }

        })

        @response = get_sepa_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  def purchase_sepa_payment_token
    @paymentToken = "MHO5nhs2HjSBcn2"
    if request.post?
      begin

        purchase = Paysafe::DirectDebit::Purchase.new(
        {
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          sepa: {
          paymentToken: params[:paymentToken]
          }
        })

        @response = get_sepa_client.direct_debit_service.submit_purchase_request purchase
      rescue Exception => e
        @response = e
      end
    end
  end

  #######################
  ## Standalone Credits
  #######################

  def standalone_credits_ach
    if request.post?
      begin
        standalone_credit_obj = Paysafe::DirectDebit::StandaloneCredits.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          ach: {
          accountHolderName: params[:accountHolderName],
          accountType: params[:accountType],
          accountNumber: params[:accountNumber],
          routingNumber: params[:routingNumber],
          payMethod: params[:payMethod]
          },
          customerIp: params[:customerIp],
          profile: {
          firstName: params[:firstName],
          lastName: params[:lastName],
          email: params[:email]
          },
          billingDetails: {
          street: params[:street],
          city: params[:city],
          state: params[:state],
          country: params[:country],
          zip: params[:zip],
          phone: params[:phone]
          }

        })

        @response = get_ach_client.direct_debit_service.submit_standalone_credit standalone_credit_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  def standalone_credits_ach_payment_token

    unless request.post?

      create_profile_and_address
      ach_bank_account_obj = Paysafe::CustomerVault::AchBankAccount.new({
        nickName: "John",
        accountNumber: rand(1000..1000000000000),
        routingNumber: "123456789",
        accountHolderName: "XYZ Business",
        billingAddressId: @address_id,
        accountType: "CHECKING",
        profileID: @profile_id
      })

      ach_bank_account = get_client.customer_vault_service.create_ach_bank_account ach_bank_account_obj
      @ach_paymentToken = ach_bank_account.paymentToken
      ach_bank_account_id = ach_bank_account.id
    end

    if request.post?

      begin
        ach_paymentToken=nil

        if params[:paymentToken].blank?

        else
          ach_paymentToken = params[:paymentToken]
        end

        standalone_credit_obj = Paysafe::DirectDebit::StandaloneCredits.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          ach: {
          paymentToken: ach_paymentToken,
          payMethod: params[:payMethod]
          },
          customerIp: params[:customerIp]
        })

        @response = get_ach_client.direct_debit_service.submit_standalone_credit standalone_credit_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  def standalone_credits_eft
    if request.post?
      begin
        standalone_credit_obj = Paysafe::DirectDebit::StandaloneCredits.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          eft: {
          accountHolderName: params[:accountHolderName],
          accountNumber: params[:accountNumber],
          transitNumber: params[:transitNumber],
          institutionId: params[:institutionId]
          },
          customerIp: params[:customerIp],
          profile: {
          firstName: params[:firstName],
          lastName: params[:lastName],
          email: params[:email]
          },
          billingDetails: {
          street: params[:street],
          city: params[:city],
          state: params[:state],
          country: params[:country],
          zip: params[:zip],
          phone: params[:phone]
          }

        })

        @response = get_eft_client.direct_debit_service.submit_standalone_credit standalone_credit_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  def standalone_credits_eft_payment_token

    unless request.post?
      create_profile_and_address
      eft_bank_account_obj = Paysafe::CustomerVault::EftBankAccount.new({
        nickName: "Sally's Bank of Montreal Account",
        accountNumber: rand(1000..100000000000),
        transitNumber: "12345",
        accountHolderName: "Bran",
        billingAddressId: @address_id,
        institutionId: "001",
        profileID: @profile_id
      })

      eft_bank_account = get_client.customer_vault_service.create_eft_bank_account eft_bank_account_obj
      @eft_paymentToken = eft_bank_account.paymentToken
      eft_bank_account_id = eft_bank_account.id
    end

    if request.post?
      begin
        eft_paymentToken = nil

        if params[:paymentToken].blank?

        else
          eft_paymentToken = params[:paymentToken]
        end

        standalone_credit_obj = Paysafe::DirectDebit::StandaloneCredits.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          eft: {
          paymentToken: eft_paymentToken
          }
        })

        @response = get_eft_client.direct_debit_service.submit_standalone_credit standalone_credit_obj
      rescue Exception => e
        @response = e
      end

    end
  end

  def standalone_credits_bacs_payment_token
    @bacs_paymentToken = "MgPnKh2gGCQ6p9m"
    if request.post?

      begin

        merchantRefNum = SecureRandom.uuid
        standalone_credit_obj = Paysafe::DirectDebit::StandaloneCredits.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          bacs: {
          paymentToken: params[:paymentToken]
          }
        })

        @response = get_bacs_client.direct_debit_service.submit_standalone_credit standalone_credit_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  private

  def get_ach_client
    @ach_client ||= Paysafe::PaysafeApiClient.new(
    SampleRailsApp::Application.config.paysafe_api_key,
    SampleRailsApp::Application.config.paysafe_api_secret,
    Paysafe::Environment::TEST,
    SampleRailsApp::Application.config.paysafe_ach_account_number
    )
  end

  def get_eft_client
    @ach_client ||= Paysafe::PaysafeApiClient.new(
    SampleRailsApp::Application.config.paysafe_api_key,
    SampleRailsApp::Application.config.paysafe_api_secret,
    Paysafe::Environment::TEST,
    SampleRailsApp::Application.config.paysafe_eft_account_number
    )
  end

  def get_sepa_client
    @ach_client ||= Paysafe::PaysafeApiClient.new(
    SampleRailsApp::Application.config.paysafe_api_key,
    SampleRailsApp::Application.config.paysafe_api_secret,
    Paysafe::Environment::TEST,
    SampleRailsApp::Application.config.paysafe_sepa_account_number
    )
  end

  def get_bacs_client
    @ach_client ||= Paysafe::PaysafeApiClient.new(
    SampleRailsApp::Application.config.paysafe_api_key,
    SampleRailsApp::Application.config.paysafe_api_secret,
    Paysafe::Environment::TEST,
    SampleRailsApp::Application.config.paysafe_bacs_account_number
    )
  end

  def get_client
    @client ||= Paysafe::PaysafeApiClient.new(
    SampleRailsApp::Application.config.paysafe_api_key,
    SampleRailsApp::Application.config.paysafe_api_secret,
    Paysafe::Environment::TEST,
    SampleRailsApp::Application.config.paysafe_account_number
    )
  end

  def create_profile_and_address
    if @profile_id.blank?
      profile_obj = Paysafe::CustomerVault::Profile.new({
        merchantCustomerId: SecureRandom.uuid,
        locale: "en_US",
        firstName: "John",
        lastName: "Smith",
        email: "john.smith@somedomain.com",
        phone: "713-444-5555"
      })

      profile = get_client.customer_vault_service.create_profile profile_obj
      @profile_id = profile.id
    end

    if @address_id.blank?
      address_obj = Paysafe::CustomerVault::Address.new({
        nickName: "home",
        street: "100 Queen Street West",
        street2: "Unit 201",
        city: "Toronto",
        country: "CA",
        state: "ON",
        zip: "M5H 2N2",
        recipientName: "Jane Doe",
        phone: "647-788-3901",
        profileID: @profile_id
      })

      address = get_client.customer_vault_service.create_address address_obj
      @address_id = address.id
    end
  end
end