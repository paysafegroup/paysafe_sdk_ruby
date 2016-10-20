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
  class DirectDebitService


    def initialize client
      @client = client # PaysafeApiClient
      @uri = "/directdebit/v1" # URI for direct debit API
    end

    def monitor
      request = Request.new({
        method: Request::GET,
        uri: "/directdebit/monitor"
      })
      @client.process_request(request)[:status] == "READY"
    end

    #############
    ## Purchases
    #############

    def submit_purchase_request purchase
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/purchases"),
        body: purchase.get(
            required = ['merchantRefNum', 'amount']
          )
      )

      response = @client.process_request request
      DirectDebit::Purchase::new response
    end

    def get_purchase_with_purchase_id purchase
      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/purchases/" + purchase.id)
      )

      response = @client.process_request request
      DirectDebit::Purchase::new response
    end

    def get_purchase_with_merchant_reference_number purchase
      uriStr = "/purchases?merchantRefNum=" + purchase.merchantRefNum
      uriStr += append_pagination(purchase.pagination) if purchase.pagination
      uriStr += "&"
      request = Request.new(
        method: Request::GET,
        uri: prepare_uri(uriStr)
      )

      response = @client.process_request request
      DirectDebit::Purchase::new response
    end

    def cancel_purchase purchase
      request = Request.new(
        method: Request::PUT,
        uri: prepare_uri("/purchases/" + purchase.id),
        body: purchase.get(
            required = ['status']
          )
      )

      response = @client.process_request request
      DirectDebit::Purchase::new response
    end  

    ######################
    # Standalone Credits
    ######################

    def submit_standalone_credit standalone_credit
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/standalonecredits"),
        body: standalone_credit.get(
            required = ['merchantRefNum', 'amount']
          )
      )

      response = @client.process_request request
      DirectDebit::StandaloneCredits::new response
    end

    def get_standalone_credit_using_id standalone_credit
      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/standalonecredits/" + standalone_credit.id)
      )

      response = @client.process_request request
      DirectDebit::StandaloneCredits::new response
    end

    def get_standalone_credit_using_merchant_reference_number standalone_credit
      uriStr = "/standalonecredits?merchantRefNum=" + standalone_credit.merchantRefNum
      uriStr += append_pagination(standalone_credit.pagination) if standalone_credit.pagination
      uriStr += "&"

      request = Request.new(
        method: Request::GET,
        uri: prepare_uri(uriStr)
      )

      response = @client.process_request request
      DirectDebit::StandaloneCredits::new response
    end

    def cancel_standalone_credit standalone_credit
      request = Request.new(
        method: Request::PUT,
        uri: prepare_uri("/standalonecredits/" + standalone_credit.id),
        body: standalone_credit.get(
            required = ['status']
          )
      )

      response = @client.process_request request
      DirectDebit::StandaloneCredits::new response
    end


    private
    # Prepare URI for submission to the API
    def prepare_uri path
      "#{@uri}/accounts/#{@client.account}#{path}"
    end

    def append_pagination(pagination)
      append_url = ""
      append_url += "&limit="+pagination[:limit] if(pagination[:limit])
      append_url += "&offset="+pagination[:offset] if(pagination[:offset])
      append_url += "&startDate="+pagination[:startDate] if(pagination[:startDate])
      append_url += "&endDate="+pagination[:endDate] if(pagination[:endDate])
      append_url
    end


  end  
end    