require 'mimemagic'

module PlateApi
  class PostMultipartRequest < Request
    HttpAdapter = :net_http
    MimeMagic.add('image/jpeg', extensions: "jfif")

    def initialize(public_key, secret, path, parameters={}, custom_server=nil)
      super(public_key, secret, "POST", path, custom_server)

      @post_parameters = map_parameters(parameters)
    end

    def extra_builder_options(builder)
      builder.request :multipart
	    builder.request :url_encoded
    end

    def extra_request_options(request)
      request.body = @post_parameters
    end

    def map_parameters(parameters)
      parameters.keys.each do |key|
        val = parameters[key]
        if val.is_a? File
          full_path = File.expand_path(val)
          mime_type = MimeMagic.by_path(full_path).type
          parameters[key] = Faraday::UploadIO.new(full_path, mime_type)
        end
      end

      return parameters
    end
  end
end
