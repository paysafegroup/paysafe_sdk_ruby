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

class ThreeDSecureController < ApplicationController
  def index
  end

  def submit_enrollment
    puts "params = #{params.inspect}"
    if request.post?
      begin

        merchantRefNum = SecureRandom.uuid
        enrollment_check = Paysafe::ThreeDSecure::EnrollmentChecks.new({
          merchantRefNum: params[:merchantRefNum],
          amount: params[:amount],
          currency: params[:currency],
          customerIp: "204.91.0.12",
          userAgent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
          acceptHeader: "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
          merchantUrl: params[:merchantUrl],
          card: {
          cardNum: params[:card_number],
          cardExpiry: {
          month: params[:date][:month],
          year: params[:date][:year]
          }
          }
        })

        @response = get_client.three_d_secure_service.submit_enrollment_lookup enrollment_check
      rescue Exception => e
        @response = e
      end
    end
  end

  def submit_authentication
    puts "params = #{params.inspect}"
    @paRes = "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"
    if request.post?
      begin

        merchantRefNum = SecureRandom.uuid

        enrollment_check = Paysafe::ThreeDSecure::EnrollmentChecks.new({
          merchantRefNum: merchantRefNum,
          amount: 100,
          currency: "USD",
          customerIp: "204.91.0.12",
          userAgent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
          acceptHeader: "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
          merchantUrl: "https://www.merchant.com",
          card: {
          cardNum: "4107857757053670",
          cardExpiry: {
          month: 10,
          year: 2018
          }
          }
        })

        enrollment_check_response = get_client.three_d_secure_service.submit_enrollment_lookup enrollment_check
        enrollment_id = enrollment_check_response.id

        authentication = Paysafe::ThreeDSecure::Authentications.new({
          merchantRefNum: params[:merchantRefNum],
          paRes: params[:paRes],
          enrollment_id: enrollment_id
        })

        @response = get_client.three_d_secure_service.submit_authentication authentication
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

end