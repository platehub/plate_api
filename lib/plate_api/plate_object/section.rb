module PlateApi::PlateObject
  class Section < Base

    has_one :post, "PlateApi::PlateObject::Post"
    has_many :rows, :row, "PlateApi::PlateObject::Row", true
    has_many :columns, :column, "PlateApi::PlateObject::Column"
    has_many :elements, :element, "PlateApi::PlateObject::Element"

    def self.api_name
      "sections"
    end

    def self.parent_class
      Post
    end
  end
end
