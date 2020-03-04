module PlateApi::PlateObject
  class SiteTranslation < Base

    has_one :site, "PlateApi::PlateObject::Site"
    has_many :posts, :post, "PlateApi::PlateObject::Post", true
    has_many :sections, :section, "PlateApi::PlateObject::Section"
    has_many :rows, :row, "PlateApi::PlateObject::Row"
    has_many :columns, :column, "PlateApi::PlateObject::Column"
    has_many :elements, :element, "PlateApi::PlateObject::Element"
    has_many :content_objects, :content_object, "PlateApi::PlateObject::ContentObject"

    def self.api_name
      "site_translations"
    end

    def self.parent_class
      Site
    end
  end
end
