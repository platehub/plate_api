require "faraday"
require 'faraday_middleware'
require 'time'
require "base64"
require "openssl"

module PlateApi
  class Request
    DefaultApiBaseEndpoint = "https://www.startwithplate.com/api/v2"

    def initialize(secret, method, path, parameters={}, custom_server=nil)
      base_api_endpoint = custom_server ? custom_server : DefaultApiBaseEndpoint

      @connection = ::Faraday.new(url: base_api_endpoint) do |faraday|
        faraday.response    :json
        faraday.adapter     Faraday.default_adapter
      end

      @secret = secret
      @method = method
      @path = path
      @parameters = @parameters
    end

    def send
      response = @connection.send(@method.downcase) do |request|
        request.url @path
        request.headers['Date'] = request_date
        request.headers['Authorization'] = calculate_signature
      end

      return response.body
    end

    def request_date
      @date ||= Time.now.httpdate
    end

    def calculate_signature
      string_to_sign = "#{@method}\n" +
                       "#{@connection.host}\n" +
                       "#{@connection.path_prefix + "/" + @path}\n" +
                       "\n" +
                       "#{request_date}\n"
      puts "String to sign:"
      puts string_to_sign
      signature = Base64.strict_encode64(OpenSSL::HMAC.digest("SHA512", @secret, string_to_sign))
      puts "hmac #{signature}"
      return "hmac #{signature}"
    end
  end
end
