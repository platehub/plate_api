module PlateApi::PlateObject
  class ContentObject < Base

    has_one :site_translation, "PlateApi::PlateObject::SiteTranslation"

    def self.api_name
      "content_objects"
    end

    def self.parent_class
      SiteTranslation
    end

  end
end
