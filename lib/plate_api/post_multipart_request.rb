module PlateApi
  class PostMultipartRequest < Request

    def initialize(public_key, secret, path, parameters={}, custom_server=nil)
      super(public_key, secret, "POST", path, custom_server)

      @post_parameters = parameters
    end

    def extra_builder_options(builder)
      builder.request :multipart
	    builder.request :url_encoded
      builder.adapter :net_http
    end

    def extra_request_options(request)
      request.headers['Content-Type'] = 'image/jpg'
      request.body = @post_parameters
    end
  end
end
