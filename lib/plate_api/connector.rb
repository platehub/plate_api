require "plate_api/get_request"
require "plate_api/delete_request"
require "plate_api/post_request"
require "plate_api/put_request"
require "plate_api/object_handler"

module PlateApi
  class Connector

    def initialize(public_key, secret_key, custom_server=nil)
      @custom_server = custom_server
      @public_key = public_key
      @secret_key = secret_key
    end

    def get(url="", parameters={})
      GetRequest.new(@public_key, @secret_key, url, parameters, @custom_server).execute
    end

    def delete(url="", parameters={})
      DeleteRequest.new(@public_key, @secret_key, url, parameters, @custom_server).execute
    end

    def put(url="", put_params={})
      PutRequest.new(@public_key, @secret_key, url, put_params, @custom_server).execute
    end

    def post(url="", post_params={})
      PostRequest.new(@public_key, @secret_key, url, post_params, @custom_server).execute
    end

    def site_handler
      @site_handler ||= ObjectHandler.new(PlateObject::Site, self)
    end
  end
end
