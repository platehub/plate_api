module PlateApi::PlateObject
  class Post < Base

    has_one :site_translation, "PlateApi::PlateObject::SiteTranslation"
    has_many :sections, :section, "PlateApi::PlateObject::Section"
    has_many :rows, :row, "PlateApi::PlateObject::Row"
    has_many :columns, :column, "PlateApi::PlateObject::Column"
    has_many :elements, :element, "PlateApi::PlateObject::Element"

    def self.api_name
      "posts"
    end

    def self.parent_class
      SiteTranslation
    end
  end
end
