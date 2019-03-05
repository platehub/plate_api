module PlateApi::PlateObject
  class Element < Base

    has_one :column, "PlateApi::PlateObject::Column"

    def self.api_name
      "elements"
    end

    def self.parent_class
      Column
    end
  end
end
