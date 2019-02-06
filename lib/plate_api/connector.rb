require "plate_api/request"

module PlateApi
  class Connector


    def initialize(secret_key, custom_server=nil)
      @custom_server = custom_server
      @secret_key = secret_key
    end

    def get_url(url="")
      Request.new(@secret_key, "GET", url, {}, @custom_server).send
    end
  end
end
