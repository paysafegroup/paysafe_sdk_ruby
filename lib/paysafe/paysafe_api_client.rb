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

require 'net/https'
require "resolv-replace.rb"
require 'uri'
require "base64"
require 'yaml'
require 'json'

modulePaysafe
  class PaysafeApiClient
    API_TEST = "https://api.test.paysafe.com"
    API_LIVE = "https://api.paysafe.com"

    # Merchant's api key
    @key_id = nil

    # Merchant's api secret
    @key_password = nil

    # Send requests to production or testing
    @environment = nil

    # Endpoint to submit requests
    @api_end_point = nil

    @account = nil
    @cert = nil

    attr_accessor :account

    def initialize(key_id, key_password, environment=Environment::TEST, account=nil, cert=nil)
      if environment != Environment::TEST and environment != Environment::LIVE
        raise PaysafeError, "Invalid environment specified"
      end

      @cert = cert
      @key_id = key_id
      @key_password = key_password
      @environment = environment
      @api_end_point = environment == Environment::TEST ? API_TEST : API_LIVE
      @account = account
    end

    def card_payment_service
      CardPaymentService.new self
    end

    def customer_vault_service
      CustomerVaultService.new self
    end

   	def direct_debit_service
      DirectDebitService.new self
    end

    def three_d_secure_service
      ThreeDSecureService.new self
    end

    def process_request request
      uri = URI.parse(request.build_url(@api_end_point))
      http = Net::HTTP.new uri.host, uri.port
      #http.set_debug_output $stderr
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.cert_store = OpenSSL::X509::Store.new
      http.cert_store.set_default_paths
      http.cert_store.add_file @cert unless @cert.nil?
      http.cert_store.add_file ENV["SSL_CERT_FILE"] unless ENV["SSL_CERT_FILE"].nil?
      if request.data[:method] == Request::GET
        net = Net::HTTP::Get.new(uri.request_uri)
      elsif request.data[:method] == Request::DELETE
        net = Net::HTTP::Delete.new(uri.path)
      elsif request.data[:method] == Request::PUT
        net = Net::HTTP::Put.new(uri.path)
        net.body = request.data[:body].to_json
      else
        net = Net::HTTP::Post.new(uri.path)
        net.body = request.data[:body].to_json
      end
      net["Authorization"] = "Basic " + Base64.strict_encode64(@key_id + ":" + @key_password)
      net["Content-Type"] = "application/json"
      response = http.request(net)
      response_code = response.code.to_i

      if request.data[:method] == Request::DELETE and response.body == ""
        return (response_code == 200)
      end

      begin
        json_response = JSON.parse(response.body, {:symbolize_names => true})
		
      rescue JSON::ParserError
        raise *get_paysafe_exception(response_code, response.body)
      end

      if json_response.is_a?(Hash)
        if response_code < 200 or response_code >= 206
          error_msg = json_response.has_key?(:error) ? json_response[:error][:message] : nil
          raise *get_paysafe_exception(response_code, error_msg, nil, json_response)
        end
      else
        raise *get_paysafe_exception(response_code)
      end
      json_response
    end

    def get_paysafe_exception http_code, message="", code=nil, response={}
      message = "An unknown error has occurred." if message == ""
      code = http_code if code.nil?
      exception = PaysafeError

      case http_code
        when 400
          exception = InvalidRequestError
        when 401
          exception = InvalidCredentialsError
        when 402
          exception = RequestDeclinedError
        when 403
          exception = PermissionError
        when 404
          exception = EntityNotFoundError
        when 409
          exception = RequestConflictError
        when 406
        when 415
          exception = APIError
        else
          exception = http_code >= 500 ? APIError : OptimalError
      end

      return exception.new(response), code.to_s + ": " + message
    end
  end
end
