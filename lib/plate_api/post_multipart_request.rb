module PlateApi
  class PostMultipartRequest < Request
    HttpAdapter = :net_http

    def initialize(public_key, secret, path, parameters = {}, custom_server = nil)
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

    def mime_type(full_path)
      begin
        IO.popen(["file", "--brief", "--mime-type", full_path], in: :close, err: :close) { |io| io.read.chomp }
      rescue SystemCallError
        # determine mime_type based on extension as a fallback, in case `file` is not installed on the client machine
        self.mime_type_fallback(full_path)
      end
    end

    def mime_type_fallback(full_path)
      MIME::Types.type_for(full_path).first.content_type
    end

    def map_parameters(parameters)
      parameters.keys.each do |key|
        val = parameters[key]
        if val.is_a? File
          full_path = File.expand_path(val)
          mime_type = self.mime_type(full_path)
          parameters[key] = Faraday::UploadIO.new(full_path, mime_type)
        end
      end

      return parameters
    end
  end
end
