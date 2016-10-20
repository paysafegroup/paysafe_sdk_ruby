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

class CustomerVaultController < ApplicationController
  PROFILE_ID = "1856acdb-19f7-4ae2-b958-63819f526c67"
  ADDRESS_ID = "cfa57745-2279-4358-bbe0-7542a9c16685"
  BACS_BANK_ACCOUNT_ID = "160ab798-2ccb-4039-a79a-7124f99daf3d"
  BACS_MANDATE_REFERENCE = "AUDDRIPIP"
  SEPA_BANK_ACCOUNT_ID = "6798b810-444e-4b80-8ba4-b39da8f991d8"
  def index
  end

  def create_ach_account
    if request.post?
      begin

        ach_bank_account_obj = Paysafe::CustomerVault::AchBankAccount.new({
          nickName: "Default ACH Business Bank Account",
          accountNumber: params[:accountNumber],
          routingNumber: params[:routingNumber],
          accountHolderName: params[:accountHolderName],
          billingAddressId: ADDRESS_ID,
          accountType: params[:accountType],
          profileID: PROFILE_ID
        })
        @response = get_client.customer_vault_service.create_ach_bank_account ach_bank_account_obj

        ach_bank_account_obj = Paysafe::CustomerVault::AchBankAccount.new({
          id: @response.id,
          profileID: PROFILE_ID
        })
        delete_response = get_client.customer_vault_service.delete_ach_bank_account ach_bank_account_obj

      rescue Exception => e
        @response = e
      end
    end
  end

  def create_eft_account
    if request.post?
      begin

        eft_bank_account_obj = Paysafe::CustomerVault::EftBankAccount.new({
          nickName: "Default EFT Business Bank Account",
          accountNumber: params[:accountNumber],
          transitNumber: params[:transitNumber],
          institutionId: params[:institutionId],
          accountHolderName: params[:accountHolderName],
          billingAddressId: ADDRESS_ID,
          profileID: PROFILE_ID
        })
        @response = get_client.customer_vault_service.create_eft_bank_account eft_bank_account_obj

        eft_bank_account_obj = Paysafe::CustomerVault::EftBankAccount.new({
          id: @response.id,
          profileID: PROFILE_ID
        })
        delete_response = get_client.customer_vault_service.delete_eft_bank_account eft_bank_account_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  def create_bacs_account
    if request.post?
      begin

        bacs_bank_account_obj = Paysafe::CustomerVault::BacsBankAccount.new({
          nickName: "Default BACS Business Bank Account",
          accountNumber: params[:accountNumber],
          sortCode: params[:sortCode],
          accountHolderName: params[:accountHolderName],
          billingAddressId: ADDRESS_ID,
          profileID: PROFILE_ID
        })
        @response = get_client.customer_vault_service.create_bacs_bank_account bacs_bank_account_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  def create_sepa_account
    if request.post?
      begin

        sepa_bank_account_obj = Paysafe::CustomerVault::SepaBankAccount.new({
          nickName: "Default SEPA Business Bank Account",
          iban: params[:iban],
          bic: params[:bic],
          accountHolderName: params[:accountHolderName],
          billingAddressId: ADDRESS_ID,
          profileID: PROFILE_ID
        })

        @response = get_client.customer_vault_service.create_sepa_bank_account sepa_bank_account_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  def create_sepa_mandate
    if request.post?
      begin

        sepa_mandate_obj = Paysafe::CustomerVault::Mandate.new({
          reference: "SUBSCRIPTION103",
          bankAccountId: SEPA_BANK_ACCOUNT_ID,
          profileID: PROFILE_ID

        })

        @response = get_sepa_client.customer_vault_service.create_sepa_mandate sepa_mandate_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  def create_bacs_mandate
    if request.post?
      begin

        bacs_mandate_obj = Paysafe::CustomerVault::Mandate.new({
          reference: BACS_MANDATE_REFERENCE,
          bankAccountId: BACS_BANK_ACCOUNT_ID,
          profileID: "d2fd5221-6c83-40fd-a113-4078c855b50d" #"0bd8883e-6294-4691-b4aa-f0ef5ec2e18a"
        })

        @response = get_bacs_client.customer_vault_service.create_bacs_mandate bacs_mandate_obj
      rescue Exception => e
        @response = e
      end
    end
  end

  private

  def get_client
    @client ||= Paysafe::PaysafeApiClient.new(
    SampleRailsApp::Application.config.paysafe_api_key,
    SampleRailsApp::Application.config.paysafe_api_secret,
    Paysafe::Environment::TEST,
    SampleRailsApp::Application.config.paysafe_account_number
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

end