module PlateApi
  class GetRequest < Request
    def initialize(public_key, secret, path, parameters={}, custom_server=nil)
      super(public_key, secret, "GET", path, custom_server)

      @url_parameters = build_url_parameters(parameters)
    end

    def url_path
      "#{@path}?#{@url_parameters}"
    end

    # Translate a Hash of url parameters to a query string
    def build_url_parameters(parameters)
      sorted_params = parameters.to_a.sort_by{|x| x[0]}
      query_string = sorted_params.map do |key, value|
        if value.is_a? Array
          value.map{|subvalue| "#{key}[]=#{subvalue}"}.join("&")
        else
          "#{key}=#{value}"
        end
      end.join("&")

      query_string
    end

    def url_parameters
      @url_parameters
    end
  end
end
