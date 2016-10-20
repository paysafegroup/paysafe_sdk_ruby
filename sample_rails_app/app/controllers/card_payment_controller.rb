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

class CardPaymentController < ApplicationController
  def simple
    if request.post?
      begin
        auth_obj = Paysafe::CardPayments::Authorization.new ({
          merchantRefNum: params[:merchant_ref_num],
          amount: params[:amount].to_i * SampleRailsApp::Application.config.currency_base_units,
          settleWithAuth: true,
          card: {
            cardNum: params[:card_number],
            cvv: params[:card_cvv],
            cardExpiry: {
              month: params[:date][:month],
              year: params[:date][:year]
            }
          },
          billingDetails: {
            street: params[:street],
            city: params[:city],
            state: params[:state],
            country: params[:country],
            zip: params[:zip]
          }
        })
        @result = get_client.card_payment_service.authorize auth_obj
      rescue Exception => e
        @result = e
      end
    end
  end

  def customer_vault
    if request.post?
      begin
        profile_obj = Paysafe::CustomerVault::Profile.new({
          merchantCustomerId: params[:merchant_customer_num],
          locale: "en_US",
          firstName: params[:first_name],
          lastName: params[:last_name],
          email: params[:email]
        })
        profile = get_client.customer_vault_service.create_profile profile_obj

        address = Paysafe::CustomerVault::Address.new({
          nickName: "home",
          street: params[:street],
          city: params[:city],
          country: params[:country],
          state: params[:state],
          zip: params[:zip],
          profileID: profile.id
        })
        address = get_client.customer_vault_service.create_address address

        card_obj = Paysafe::CustomerVault::Card.new({
          nickName: "Default Card",
          cardNum: params[:card_number],
          #cvv: params[:card_cvv],
          cardExpiry: {
            month: params[:date][:month],
            year: params[:date][:year]
          },
          billingAddressId: address.id,
          profileID: profile.id
        })
        card = get_client.customer_vault_service.create_card card_obj

        auth_obj = Paysafe::CardPayments::Authorization.new ({
          merchantRefNum: params[:merchant_ref_num],
          amount: params[:amount].to_i * SampleRailsApp::Application.config.currency_base_units.to_i,
          settleWithAuth: true,
          card: {
            paymentToken: card.paymentToken
          }
        })
        @result = get_client.card_payment_service.authorize auth_obj
      rescue Exception => e
        puts "Error message = #{e.message}"
        @result = e
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
end
