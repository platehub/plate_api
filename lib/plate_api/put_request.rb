module PlateApi
  class PutRequest < Request

    def initialize(public_key, secret, path, parameters={}, custom_server=nil)
      super(public_key, secret, "PUT", path, custom_server)

      @put_parameters = parameters.to_json
    end

    def extra_request_options(request)
      request.headers['Content-Type'] = 'application/json'
      request.body = @put_parameters
    end
  end
end
