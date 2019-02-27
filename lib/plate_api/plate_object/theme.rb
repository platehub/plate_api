module PlateApi::PlateObject
  class Theme < Base

    def initialize(id, attributes, relations, object_handler=nil)
      super(id, attributes, relations, object_handler)
    end

    def self.api_name
      "themes"
    end
  end
end
