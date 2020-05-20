require "faraday"
# require 'faraday_middleware'
require 'time'
require "base64"
require "openssl"
require "json"


module PlateApi
  class Request
    DefaultApiBaseEndpoint = "https://www.startwithplate.com/api/v2"
    HttpAdapter = Faraday.default_adapter

    def initialize(public_key, secret, method, path, custom_server=nil)
      base_api_endpoint = custom_server ? custom_server : DefaultApiBaseEndpoint

      @connection = ::Faraday.new(url: base_api_endpoint) do |faraday|
        extra_builder_options(faraday)
        faraday.adapter     HttpAdapter
      end

      @public_key = public_key
      @secret = secret
      @method = method
      @path = strip_path(path)
    end

    def execute(response_type=:raw)
      response = @connection.send(@method.downcase) do |request|
        request.url url_path
        request.headers['Date'] = request_date
        request.headers['Authorization'] = calculate_signature
        extra_request_options(request)
      end

      return case response_type
      when :raw
        return response.body
      when :json
        return JSON.parse(response.body)
      end
    end

    def request_date
      @date ||= Time.now.httpdate
    end

    def calculate_signature
      string_to_sign = "#{@method}\n" +
                       "#{@connection.host}\n" +
                       "#{@connection.path_prefix}/#{@path}\n" +
                       "#{url_parameters}\n" +
                       "#{request_date}"
      signature = Base64.strict_encode64(OpenSSL::HMAC.digest("SHA512", @secret, string_to_sign))
      return "hmac #{@public_key}:#{signature}"
    end

    private

    def url_path
      @path
    end

    def url_parameters
      ""
    end

    def extra_request_options(request)
    end

    def extra_builder_options(request)
    end

    def strip_path(path)
      path.gsub(/^\/|\/$/, '')
    end
  end
end
