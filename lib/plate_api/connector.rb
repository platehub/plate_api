module PlateApi
  class Connector

    def initialize(public_key, secret_key, custom_server=nil)
      @custom_server = custom_server
      @public_key = public_key
      @secret_key = secret_key
      @handling_classes = {}
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

    def handler(handled_class)
      @handling_classes[handled_class] ||= ObjectHandler.new(handled_class, self)
    end

    def site_handler
      @site_handler ||= ObjectHandler.new(PlateObject::Site, self)
    end

    def theme_handler
      @theme_handler ||= ObjectHandler.new(PlateObject::Theme, self)
    end

    def company_handler
      @company_handler ||= ObjectHandler.new(PlateObject::Company, self)
    end

    def partner_handler
      @partner_handler ||= ObjectHandler.new(PlateObject::Partner, self)
    end
  end
end
