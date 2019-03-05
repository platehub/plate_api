module PlateApi
  class DeleteRequest < Request
    def initialize(public_key, secret, path, parameters={}, custom_server=nil)
      super(public_key, secret, "DELETE", path, custom_server)

      sorted_params = parameters.to_a.sort_by{|x| x[0]}
      @url_parameters = sorted_params.map{|x| "#{x[0]}=#{x[1]}"}.join("&")
    end

    def url_path
      "#{@path}?#{@url_parameters}"
    end

    def url_parameters
      @url_parameters
    end
  end
end
