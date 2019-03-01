module PlateApi::PlateObject
  class Row < Base

    has_one :section, "PlateApi::PlateObject::Section"
    has_many :columns, :column, "PlateApi::PlateObject::Column", true
    has_many :elements, :element, "PlateApi::PlateObject::Element"

    def self.api_name
      "rows"
    end

    def self.parent_class
      Section
    end
  end
end
