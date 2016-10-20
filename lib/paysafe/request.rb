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

require 'uri'
require "yaml"

module Paysafe
  class Request
    POST = "POST";
    GET = "GET";
    DELETE = "DELETE";
    PUT = "PUT";

    # stores data for paysafe api client
    @data = nil

    attr_accessor :data

    # Build url for the paysafe api client.
    def build_url api_end_point
      if @data[:url].nil?
        return api_end_point + @data[:uri] + "?" +
          URI.encode(@data[:query].map{|k,v| "#{k}=#{v}"}.join("&"))
      end

      if @data[:url].index(api_end_point) != 0
        raise PaysafeError, "Unexpected endpoint in url: #{@data[:url]} expected: #{api_end_point}"
      end

      return @data[:url]
    end

    def initialize args
      self.data = {
        uri: '',
        method: Request::GET,
        body: nil,
        query: {},
        url: nil
      }
      if args.is_a?(Hash)
        args.each do |key, value|
          self.data[key.to_sym] = value
        end
      elsif args.is_a?(Paysafe::Link)
        self.data[:url] = args[:href]
      end
    end
  end
end