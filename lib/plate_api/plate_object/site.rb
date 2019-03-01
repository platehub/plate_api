module PlateApi::PlateObject
  class Site < Base

    has_one :theme, "PlateApi::PlateObject::Theme"
    has_one :company, "PlateApi::PlateObject::Company"
    has_many :site_translations, :site_translation, "PlateApi::PlateObject::SiteTranslation"
    has_many :posts, :post, "PlateApi::PlateObject::Post"
    has_many :sections, :section, "PlateApi::PlateObject::Section"
    has_many :rows, :row, "PlateApi::PlateObject::Row"
    has_many :columns, :column, "PlateApi::PlateObject::Column"
    has_many :elements, :element, "PlateApi::PlateObject::Element"
    has_many :attachments, :attachment, "PlateApi::PlateObject::Attachment"

    def self.api_name
      "sites"
    end

    def self.parent_class
      Company
    end
  end
end
