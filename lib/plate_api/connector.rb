module PlateApi
  class Connector

    def initialize(public_key, secret_key, custom_server=nil)
      @custom_server = custom_server
      @public_key = public_key
      @secret_key = secret_key
      @handling_classes = {}
    end

    def get(url="", parameters={}, response_type=:json)
      GetRequest.new(@public_key, @secret_key, url, parameters, @custom_server).execute(response_type)
    end

    def delete(url="", parameters={}, response_type=:json)
      DeleteRequest.new(@public_key, @secret_key, url, parameters, @custom_server).execute(response_type)
    end

    def put(url="", put_params={}, response_type=:json)
      PutRequest.new(@public_key, @secret_key, url, put_params, @custom_server).execute(response_type)
    end

    def post(url="", post_params={}, response_type=:json)
      PostRequest.new(@public_key, @secret_key, url, post_params, @custom_server).execute(response_type)
    end

    def post_multipart(url="", post_params={}, response_type=:json)
      PostMultipartRequest.new(@public_key, @secret_key, url, post_params, @custom_server).execute(response_type)
    end

    def handler(handled_class)
      @handling_classes[handled_class] ||= ObjectHandler.new(handled_class, self)
    end

    def self.plate_object_classes
      {
        sites: PlateApi::PlateObject::Site,
        partners: PlateApi::PlateObject::Partner,
        companies: PlateApi::PlateObject::Company,
        themes: PlateApi::PlateObject::Theme,
        site_translations: PlateApi::PlateObject::SiteTranslation,
        posts: PlateApi::PlateObject::Post,
        sections: PlateApi::PlateObject::Section,
        rows: PlateApi::PlateObject::Row,
        columns: PlateApi::PlateObject::Column,
        elements: PlateApi::PlateObject::Element,
        content_objects: PlateApi::PlateObject::ContentObject,
        attachments: PlateApi::PlateObject::Attachment
      }
    end

    self.plate_object_classes.each do |k,v|
      define_method(k) do
        return handler(v)
      end
    end


  end
end
