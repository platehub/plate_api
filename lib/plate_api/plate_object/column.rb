module PlateApi::PlateObject
  class Column < Base

    has_one :row, "PlateApi::PlateObject::Row"
    has_many :elements, :element, "PlateApi::PlateObject::Element"

    def self.api_name
      "columns"
    end

    def self.parent_class
      Row
    end
  end
end
