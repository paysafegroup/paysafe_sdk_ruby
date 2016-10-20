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
  class ThreeDSecureService


    def initialize client
      @client = client # PaysafeApiClient
      @uri = "/threedsecure/v1" # URI for  threedsecure API
    end

    def monitor
      request = Request.new({
        method: Request::GET,
        uri: "/threedsecure/monitor"
      })
      @client.process_request(request)[:status] == "READY"
    end

    ##############
    ## Enrollment
    ##############

    def submit_enrollment_lookup enrollment
    	request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/enrollmentchecks"),
        body: enrollment.get(
            required = ['merchantRefNum', 'amount', 'currency', 'card',
            						'customerIp', 'userAgent', 'acceptHeader', 'merchantUrl']
          )
        )
      
      response = @client.process_request request

      enrollment = ThreeDSecure::EnrollmentChecks::new response
      enrollment.card[:type]= response[:card][:cardType]
      enrollment.card.delete(:cardType)
      enrollment
    end

    def get_enrollment enrollment
    	request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/enrollmentchecks/" + enrollment.id)
        )
      
      response = @client.process_request request
      ThreeDSecure::EnrollmentChecks::new response
    end

    ###################
    ## Authentication
    ###################

    def submit_authentication authentication
    	request = Request.new(
    		method: Request::POST,
    		uri: prepare_uri("/enrollmentchecks/" + authentication.enrollment_id + "/authentications"),
    		body: authentication.get(
            required = ['merchantRefNum', 'paRes'],
            ignore = ['enrollment_id']
          )
    		)
    	response = @client.process_request request
      ThreeDSecure::Authentications::new response
    end

    def get_authentication authentication
    	request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/authentications/" + authentication.id)
        )
      
      response = @client.process_request request
      ThreeDSecure::Authentications::new response
    end

    def get_authentication_and_enrollment_check authentication
    	request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/authentications/" + authentication.id),
        query: {:fields => 'enrollmentchecks'}

        )
      
      response = @client.process_request request
      ThreeDSecure::Authentications::new response
    end


    private
    # Prepare URI for submission to the API
    def prepare_uri path
      "#{@uri}/accounts/#{@client.account}#{path}"
    end


	end
end