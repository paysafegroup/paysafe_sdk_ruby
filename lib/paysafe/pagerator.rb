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
  class Pagerator < JsonObject

    attr_accessor :results, :position

    def initialize data, client, obj
      @client = client
      @position = 0
      @next_page = nil
      @obj = obj
      @array_key = obj.get_pageable_array_key
      throw "Pagerator key not defined" if @array_key.nil?
      parse(data)
    end

    # Return current element
    def current
      @results[@position]
    end

    # Go to next element
    def next
      @position += 1
      if !valid? and @next_page != nil
        request = Request.new({
          method: Request::GET,
          url: @next_page
        })
        @next_page = nil
        response = @client.process_request request
        parse response
        rewind
      end
      valid? ? current : false
    end

    # Reset position
    def rewind
      @position = 0
    end

    # Return all results
    def get_results
      @results
    end

    # Parse pagerator data
    def parse data
      @results = data[@array_key.to_sym]
      if data.has_key?(:links)
        data[:links].each do |link|
          @next_page = link[:href] if link[:rel] == "next"
        end
      end
    end

    # Checks if current position is valid
    def valid?
      results.length > position
    end
  end
end