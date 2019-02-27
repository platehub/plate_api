module PlateApi::PlateObject
  class Site < Base

    has_one :theme, "PlateApi::PlateObject::Theme"
    has_one :company, "PlateApi::PlateObject::Company"

    def name
      @attributes["name"]
    end

    def self.api_name
      "sites"
    end

    def self.parent_class
      Company
    end
  end
end
